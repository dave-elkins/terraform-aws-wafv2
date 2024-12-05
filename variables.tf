variable "create" {
  description = "Controls if Web ACL should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "s3_bucket_id" {
  description = "s3 bucket id for logging"
  type        = string
}

variable "tags" {
  description = "tags to add to resources"
  type        = map(any)
  default     = {}
}

variable "name" {
  description = "name to use for resources"
  type        = string
}

variable "scope" {
  description = "scope for Web ACL. options: REGIONAL, CLOUDFRONT"
  type        = string
  default     = "REGIONAL"
}

variable "default_action_allow" {
  description = "true = default action is to allow traffic. false = default action is to block traffic"
  type        = bool
  default     = true
}

variable "acl_cloudwatch_metrics_enabled" {
  description = "enable cloudwatch metrics for ACL"
  type        = bool
  default     = true
}

variable "acl_metric_name" {
  description = "metric name for ACL"
  type        = string
  default     = null
}

variable "acl_sampled_requests_enabled" {
  description = "enable sampling requests for cloudwatch metrics"
  type        = bool
  default     = true
}

variable "resource_arn" {
  description = "ARN to the resource to attach to the Web ACL"
  type        = string
  default     = null
}

variable "rate_limit_rules" {
  description = "rate limit rules"

  type = map(object({
    priority                   = number
    action                     = string
    limit                      = number
    aggregate_key_type         = string
    geo_matches                = list(string)
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  }))

  default = {}
}

variable "restrict_country_code_rules" {
  description = "restrict country code rules"

  type = map(object({
    priority                   = number
    action                     = string
    country_codes              = list(string)
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  }))

  default = {}
}

variable "rule_groups" {
  description = "rule group based rules"

  type = map(object({
    priority                   = number
    override_action            = bool
    rule_group_arn             = string
    excluded_rules             = list(string)
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  }))

  default = {}
}

variable "managed_rule_sets" {
  description = "managed rule sets"

  type = map(object({
    priority                   = number
    override_action            = bool
    rule_set_name              = string
    vendor_name                = string
    excluded_rules             = list(string),
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  }))

  default = {
    "rules-aws-common-rule-set" = {
      priority                   = 10
      override_action            = false
      rule_set_name              = "AWSManagedRulesCommonRuleSet"
      vendor_name                = "AWS"
      excluded_rules             = []
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-common"
      sampled_requests_enabled   = true
    },
    "rules-aws-admin-protect-rule-set" = {
      priority                   = 20
      override_action            = false
      rule_set_name              = "AWSManagedRulesAdminProtectRuleSet"
      vendor_name                = "AWS"
      excluded_rules             = []
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-admin-protect"
      sampled_requests_enabled   = true
    },
    "rules-aws-known-bad-inputs-rule-set" = {
      priority                   = 30
      override_action            = false
      rule_set_name              = "AWSManagedRulesKnownBadInputsRuleSet"
      vendor_name                = "AWS"
      excluded_rules             = []
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-admin-protect"
      sampled_requests_enabled   = true
    },
    "rules-aws-sqli-rule-set" = {
      priority                   = 40
      override_action            = false
      rule_set_name              = "AWSManagedRulesSQLiRuleSet"
      vendor_name                = "AWS"
      excluded_rules             = []
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-sqli"
      sampled_requests_enabled   = true
    },
    "rules-aws-linux-rule-set" = {
      priority                   = 50
      override_action            = false
      rule_set_name              = "AWSManagedRulesLinuxRuleSet"
      vendor_name                = "AWS"
      excluded_rules             = []
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-linux"
      sampled_requests_enabled   = true
    },
    "rules-aws-posix-rule-set" = {
      priority                   = 60
      override_action            = false
      rule_set_name              = "AWSManagedRulesPosixRuleSet"
      vendor_name                = "AWS"
      excluded_rules             = []
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-posix"
      sampled_requests_enabled   = true
    }
  }
}
