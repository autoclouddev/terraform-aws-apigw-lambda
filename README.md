<!-- BEGIN_TF_DOCS -->
Terraform AWS API Gateway Lambda Module
=======================================

## Overview

Deploys a serverless service to AWS using API Gateway and Lambda.

## Specifications

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.3 |
| <a name="requirement_archive"></a> [archive](#requirement_archive) | ~> 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 4.0 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider_aws) | 4.67.0 |

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apigateway-v2"></a> [apigateway-v2](#module_apigateway-v2) | terraform-aws-modules/apigateway-v2/aws | 2.2.2 |
| <a name="module_lambda_function"></a> [lambda_function](#module_lambda_function) | terraform-aws-modules/lambda/aws | ~> 3.0 |

#### Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_api_mapping.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_stage.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [archive_file.this](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_route53_zone.hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input_description) | Description of service applied to deployed resources | `string` | n/a | yes |
| <a name="input_domain_name_certificate_arn"></a> [domain_name_certificate_arn](#input_domain_name_certificate_arn) | ACM Certificate ARN to use for SSL encryption | `string` | n/a | yes |
| <a name="input_existing_filename"></a> [existing_filename](#input_existing_filename) | Relative path to service Lambda function source file | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input_hostname) | DNS name given to the api gateway domain assigned. Is the rt53 record name$var.hostname.$var.domain_name | `string` | n/a | yes |
| <a name="input_create_default_stage"></a> [create_default_stage](#input_create_default_stage) | Whether or not to create a default stage in the API gateway. Defaults to false, no default stage. | `bool` | `false` | no |
| <a name="input_create_default_stage_api_mapping"></a> [create_default_stage_api_mapping](#input_create_default_stage_api_mapping) | Whether or not to create a default stage mapping in the API gateway. Defaults to false, no default stage. | `bool` | `false` | no |
| <a name="input_create_package"></a> [create_package](#input_create_package) | Whether to upload the lambda file to s3. Should be false | `bool` | `false` | no |
| <a name="input_detailed_metrics_enabled"></a> [detailed_metrics_enabled](#input_detailed_metrics_enabled) | Whether or not detailed metrics are enabled for the service Lambda, defaults to false, no detailed metrics. | `bool` | `false` | no |
| <a name="input_disable_execute_api_endpoint"></a> [disable_execute_api_endpoint](#input_disable_execute_api_endpoint) | Whether or not to disable the Lambda execute API endpoint, defaults to true, no execute endpoint | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `null` | no |
| <a name="input_function_handler"></a> [function_handler](#input_function_handler) | Name of service Lambda function entry point | `string` | `"index.handler"` | no |
| <a name="input_hosted_zone_id"></a> [hosted_zone_id](#input_hosted_zone_id) | Route53 zone ID for creating the API Gateway's record, must provide either zone name or zone ID | `string` | `null` | no |
| <a name="input_hosted_zone_name"></a> [hosted_zone_name](#input_hosted_zone_name) | Route53 zone name for creating the API Gateway's record, must provide either zone name or zone ID | `string` | `null` | no |
| <a name="input_hosted_zone_private"></a> [hosted_zone_private](#input_hosted_zone_private) | Whether or not the Route53 zone is private, defaults to false, public zone | `bool` | `false` | no |
| <a name="input_integration_timeout_milliseconds"></a> [integration_timeout_milliseconds](#input_integration_timeout_milliseconds) | Number of seconds to wait for a response from Lambda | `number` | `30000` | no |
| <a name="input_name"></a> [name](#input_name) | Module name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_publish"></a> [publish](#input_publish) | Whether or not to publish a version of the service Lambda, defaults to true, publish version | `bool` | `true` | no |
| <a name="input_runtime"></a> [runtime](#input_runtime) | Service Lambda runtime | `string` | `"nodejs18.x"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_throttling_burst_limit"></a> [throttling_burst_limit](#input_throttling_burst_limit) | API gateway throttling burst limit | `number` | `100` | no |
| <a name="input_throttling_rate_limit"></a> [throttling_rate_limit](#input_throttling_rate_limit) | API Gateway throttling rate limit | `number` | `100` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled"></a> [enabled](#output_enabled) | Whether or not the module is enabled |
| <a name="output_environment"></a> [environment](#output_environment) | Environment of the asset |
| <a name="output_name"></a> [name](#output_name) | Name of the asset |
| <a name="output_namespace"></a> [namespace](#output_namespace) | Namespace of the asset |
| <a name="output_tags"></a> [tags](#output_tags) | Tags for the asset |
<!-- END_TF_DOCS -->