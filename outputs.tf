###
# Standard Outputs
#
output "enabled" {
  description = "Whether or not the module is enabled"
  value       = var.enabled
}

output "environment" {
  description = "Environment of the asset"
  value       = var.environment
}

output "name" {
  description = "Name of the asset"
  value       = var.name
}

output "namespace" {
  description = "Namespace of the asset"
  value       = var.namespace
}

output "tags" {
  description = "Tags for the asset"
  value       = var.tags
}

###
# Module Outputs
#
