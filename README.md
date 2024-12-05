# terraform-aws-wafv2
A terraform module for AWS WAF V2

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.46 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.80.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kinesis_firehose_delivery_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_wafv2_web_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_wafv2_web_acl_logging_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration) | resource |
| [aws_iam_policy_document.assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl_cloudwatch_metrics_enabled"></a> [acl\_cloudwatch\_metrics\_enabled](#input\_acl\_cloudwatch\_metrics\_enabled) | enable cloudwatch metrics for ACL | `bool` | `true` | no |
| <a name="input_acl_metric_name"></a> [acl\_metric\_name](#input\_acl\_metric\_name) | metric name for ACL | `string` | `null` | no |
| <a name="input_acl_sampled_requests_enabled"></a> [acl\_sampled\_requests\_enabled](#input\_acl\_sampled\_requests\_enabled) | enable sampling requests for cloudwatch metrics | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if Web ACL should be created (it affects almost all resources) | `bool` | `true` | no |
| <a name="input_default_action_allow"></a> [default\_action\_allow](#input\_default\_action\_allow) | true = default action is to allow traffic. false = default action is to block traffic | `bool` | `true` | no |
| <a name="input_managed_rule_sets"></a> [managed\_rule\_sets](#input\_managed\_rule\_sets) | managed rule sets | <pre>map(object({<br/>    priority                   = number<br/>    override_action            = bool<br/>    rule_set_name              = string<br/>    vendor_name                = string<br/>    excluded_rules             = list(string),<br/>    cloudwatch_metrics_enabled = bool<br/>    metric_name                = string<br/>    sampled_requests_enabled   = bool<br/>  }))</pre> | <pre>{<br/>  "rules-aws-admin-protect-rule-set": {<br/>    "cloudwatch_metrics_enabled": true,<br/>    "excluded_rules": [],<br/>    "metric_name": "aws-admin-protect",<br/>    "override_action": false,<br/>    "priority": 20,<br/>    "rule_set_name": "AWSManagedRulesAdminProtectRuleSet",<br/>    "sampled_requests_enabled": true,<br/>    "vendor_name": "AWS"<br/>  },<br/>  "rules-aws-common-rule-set": {<br/>    "cloudwatch_metrics_enabled": true,<br/>    "excluded_rules": [],<br/>    "metric_name": "aws-common",<br/>    "override_action": false,<br/>    "priority": 10,<br/>    "rule_set_name": "AWSManagedRulesCommonRuleSet",<br/>    "sampled_requests_enabled": true,<br/>    "vendor_name": "AWS"<br/>  },<br/>  "rules-aws-known-bad-inputs-rule-set": {<br/>    "cloudwatch_metrics_enabled": true,<br/>    "excluded_rules": [],<br/>    "metric_name": "aws-admin-protect",<br/>    "override_action": false,<br/>    "priority": 30,<br/>    "rule_set_name": "AWSManagedRulesKnownBadInputsRuleSet",<br/>    "sampled_requests_enabled": true,<br/>    "vendor_name": "AWS"<br/>  },<br/>  "rules-aws-linux-rule-set": {<br/>    "cloudwatch_metrics_enabled": true,<br/>    "excluded_rules": [],<br/>    "metric_name": "aws-linux",<br/>    "override_action": false,<br/>    "priority": 50,<br/>    "rule_set_name": "AWSManagedRulesLinuxRuleSet",<br/>    "sampled_requests_enabled": true,<br/>    "vendor_name": "AWS"<br/>  },<br/>  "rules-aws-posix-rule-set": {<br/>    "cloudwatch_metrics_enabled": true,<br/>    "excluded_rules": [],<br/>    "metric_name": "aws-posix",<br/>    "override_action": false,<br/>    "priority": 60,<br/>    "rule_set_name": "AWSManagedRulesPosixRuleSet",<br/>    "sampled_requests_enabled": true,<br/>    "vendor_name": "AWS"<br/>  },<br/>  "rules-aws-sqli-rule-set": {<br/>    "cloudwatch_metrics_enabled": true,<br/>    "excluded_rules": [],<br/>    "metric_name": "aws-sqli",<br/>    "override_action": false,<br/>    "priority": 40,<br/>    "rule_set_name": "AWSManagedRulesSQLiRuleSet",<br/>    "sampled_requests_enabled": true,<br/>    "vendor_name": "AWS"<br/>  }<br/>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | name to use for resources | `string` | n/a | yes |
| <a name="input_rate_limit_rules"></a> [rate\_limit\_rules](#input\_rate\_limit\_rules) | rate limit rules | <pre>map(object({<br/>    priority                   = number<br/>    action                     = string<br/>    limit                      = number<br/>    aggregate_key_type         = string<br/>    geo_matches                = list(string)<br/>    cloudwatch_metrics_enabled = bool<br/>    metric_name                = string<br/>    sampled_requests_enabled   = bool<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_arn"></a> [resource\_arn](#input\_resource\_arn) | ARN to the resource to attach to the Web ACL | `string` | `null` | no |
| <a name="input_restrict_country_code_rules"></a> [restrict\_country\_code\_rules](#input\_restrict\_country\_code\_rules) | restrict country code rules | <pre>map(object({<br/>    priority                   = number<br/>    action                     = string<br/>    country_codes              = list(string)<br/>    cloudwatch_metrics_enabled = bool<br/>    metric_name                = string<br/>    sampled_requests_enabled   = bool<br/>  }))</pre> | `{}` | no |
| <a name="input_rule_groups"></a> [rule\_groups](#input\_rule\_groups) | rule group based rules | <pre>map(object({<br/>    priority                   = number<br/>    override_action            = bool<br/>    rule_group_arn             = string<br/>    excluded_rules             = list(string)<br/>    cloudwatch_metrics_enabled = bool<br/>    metric_name                = string<br/>    sampled_requests_enabled   = bool<br/>  }))</pre> | `{}` | no |
| <a name="input_s3_bucket_id"></a> [s3\_bucket\_id](#input\_s3\_bucket\_id) | s3 bucket id for logging | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | scope for Web ACL. options: REGIONAL, CLOUDFRONT | `string` | `"REGIONAL"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to add to resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wafv2_application_integration_url"></a> [wafv2\_application\_integration\_url](#output\_wafv2\_application\_integration\_url) | The URL to use in SDK integrations with managed rule groups. |
| <a name="output_wafv2_arn"></a> [wafv2\_arn](#output\_wafv2\_arn) | Web ACL ARN |
| <a name="output_wafv2_capacity"></a> [wafv2\_capacity](#output\_wafv2\_capacity) | The Web ACL Capacity Units (WCUs) currently being used by this Web ACL |
| <a name="output_wafv2_id"></a> [wafv2\_id](#output\_wafv2\_id) | Web ACL Id |
<!-- END_TF_DOCS -->
