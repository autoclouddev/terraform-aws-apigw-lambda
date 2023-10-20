###
# Standard Variables
#
variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "environment" {
  type        = string
  default     = null
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "name" {
  type        = string
  default     = null
  description = "Module name, e.g. 'app' or 'jenkins'"
}

variable "namespace" {
  type        = string
  default     = null
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

###
# Module Variables
#
variable "description" {
  type        = string
  description = "Description of service applied to deployed resources"
}

variable "create_default_stage" {
  type        = bool
  default     = false
  description = "Whether or not to create a default stage in the API gateway. Defaults to false, no default stage."
}

variable "create_default_stage_api_mapping" {
  type        = bool
  default     = false
  description = "Whether or not to create a default stage mapping in the API gateway. Defaults to false, no default stage."
}

variable "domain_name_certificate_arn" {
  type        = string
  description = "ACM Certificate ARN to use for SSL encryption"
}

variable "detailed_metrics_enabled" {
  type        = bool
  default     = false
  description = "Whether or not detailed metrics are enabled for the service Lambda, defaults to false, no detailed metrics."
}

variable "throttling_burst_limit" {
  type        = number
  default     = 100
  description = "API gateway throttling burst limit"
}

variable "throttling_rate_limit" {
  type        = number
  default     = 100
  description = "API Gateway throttling rate limit"
}

variable "integration_timeout_milliseconds" {
  type        = number
  default     = 30000
  description = "Number of seconds to wait for a response from Lambda"
}

variable "disable_execute_api_endpoint" {
  type        = bool
  default     = true
  description = "Whether or not to disable the Lambda execute API endpoint, defaults to true, no execute endpoint"
}

variable "function_handler" {
  type        = string
  default     = "index.handler"
  description = "Name of service Lambda function entry point"
}

variable "runtime" {
  type        = string
  default     = "nodejs18.x"
  description = "Service Lambda runtime"
}

variable "publish" {
  type        = bool
  default     = true
  description = "Whether or not to publish a version of the service Lambda, defaults to true, publish version"
}

variable "create_package" {
  type        = bool
  default     = false
  description = "Whether to upload the lambda file to s3. Should be false"
}

variable "existing_filename" {
  type        = string
  description = "Relative path to service Lambda function source file"
}

variable "hosted_zone_id" {
  type        = string
  default     = null
  description = "Route53 zone ID for creating the API Gateway's record, must provide either zone name or zone ID"
}

variable "hosted_zone_name" {
  type        = string
  default     = null
  description = "Route53 zone name for creating the API Gateway's record, must provide either zone name or zone ID"
}

variable "hosted_zone_private" {
  type        = bool
  default     = false
  description = "Whether or not the Route53 zone is private, defaults to false, public zone"
}

variable "hostname" {
  type        = string
  description = "DNS name given to the api gateway domain assigned. Is the rt53 record name$var.hostname.$var.domain_name"
}
