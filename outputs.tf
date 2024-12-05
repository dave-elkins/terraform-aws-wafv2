output "wafv2_arn" {
  description = "Web ACL ARN"
  value       = var.create ? aws_wafv2_web_acl.this[0].arn : ""
}

output "wafv2_capacity" {
  description = "The Web ACL Capacity Units (WCUs) currently being used by this Web ACL"
  value       = var.create ? aws_wafv2_web_acl.this[0].capacity : 0
}

output "wafv2_id" {
  description = "Web ACL Id"
  value       = var.create ? aws_wafv2_web_acl.this[0].id : ""
}

output "wafv2_application_integration_url" {
  description = "The URL to use in SDK integrations with managed rule groups."
  value       = var.create ? aws_wafv2_web_acl.this[0].application_integration_url : ""
}
