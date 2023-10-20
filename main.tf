locals {

  function_name = format("%s-%s-%s", var.namespace, var.environment, var.name)

  tags = merge(
    {
      Environment = var.environment
      Name        = var.name
      Namespace   = var.namespace
    },
    var.tags
  )
}


################
# Data sources #
################
data "aws_route53_zone" "hosted_zone" {
  name         = var.hosted_zone_name
  private_zone = var.hosted_zone_private
  zone_id      = var.hosted_zone_id
}

data "archive_file" "this" {
  type        = "zip"
  source_file = "${path.root}/${var.existing_filename}"
  output_path = "${path.root}/${var.existing_filename}.zip"
}

#####################################################
# API Gateway v2 HTTP API + Domain + Mappings + DNS #
#####################################################

module "apigateway-v2" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "2.2.2"

  name        = local.function_name
  description = var.description

  protocol_type                    = "HTTP"
  create_default_stage             = var.create_default_stage
  create_default_stage_api_mapping = var.create_default_stage_api_mapping
  domain_name                      = "${var.hostname}.${data.aws_route53_zone.hosted_zone.name}"
  domain_name_certificate_arn      = var.domain_name_certificate_arn
  disable_execute_api_endpoint     = var.disable_execute_api_endpoint

  default_route_settings = {
    detailed_metrics_enabled = var.detailed_metrics_enabled
    throttling_burst_limit   = var.throttling_burst_limit
    throttling_rate_limit    = var.throttling_rate_limit
  }

  integrations = {
    "ANY /" = {
      lambda_arn             = module.lambda_function.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = var.integration_timeout_milliseconds
      integration_type       = "AWS_PROXY"
      connection_type        = "INTERNET"
    }
  }

  tags = local.tags
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = module.apigateway-v2.apigatewayv2_api_id
  name        = "default"
  auto_deploy = true
  default_route_settings {
    throttling_burst_limit = var.throttling_burst_limit
    throttling_rate_limit  = var.throttling_rate_limit
  }

  tags = local.tags
}

resource "aws_apigatewayv2_api_mapping" "this" {
  api_id      = module.apigateway-v2.apigatewayv2_api_id
  domain_name = module.apigateway-v2.apigatewayv2_domain_name_id
  stage       = aws_apigatewayv2_stage.this.id
}

resource "aws_route53_record" "this" {
  name    = var.hostname
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"
  alias {
    name                   = module.apigateway-v2.apigatewayv2_domain_name_target_domain_name
    zone_id                = module.apigateway-v2.apigatewayv2_domain_name_hosted_zone_id
    evaluate_target_health = false
  }
}

##########
# Lambda #
##########

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 3.0"

  function_name = local.function_name
  description   = var.description
  handler       = var.function_handler
  runtime       = var.runtime

  publish = var.publish

  create_package         = var.create_package
  local_existing_package = data.archive_file.this.output_path

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.apigateway-v2.apigatewayv2_api_execution_arn}/*/*"
    }
    AllowExecutionFromAPIGatewayPayment = {
      service    = "apigateway"
      source_arn = "${module.apigateway-v2.apigatewayv2_api_execution_arn}/*/*/payment"
    }
  }

  tags = local.tags
}
