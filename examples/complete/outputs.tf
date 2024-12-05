output "wafv2_arn" {
  description = "Web ACL ARN"
  value       = module.wafv2.wafv2_arn
}

output "wafv2_capacity" {
  description = "The Web ACL Capacity Units (WCUs) currently being used by this Web ACL"
  value       = module.wafv2.wafv2_capacity
}

output "wafv2_id" {
  description = "Web ACL Id"
  value       = module.wafv2.wafv2_id
}

output "wafv2_application_integration_url" {
  description = "The URL to use in SDK integrations with managed rule groups."
  value       = module.wafv2.wafv2_application_integration_url
}
