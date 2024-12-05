locals {
  name = var.name
}

resource "aws_wafv2_web_acl" "this" {
  count = var.create ? 1 : 0

  name        = local.name
  description = "${local.name} Web ACL"
  scope       = var.scope

  default_action {
    dynamic "allow" {
      for_each = var.default_action_allow ? [1] : []
      content {}
    }

    dynamic "block" {
      for_each = var.default_action_allow ? [] : [1]
      content {}
    }
  }

  dynamic "rule" {
    for_each = var.managed_rule_sets

    content {
      name     = rule.key
      priority = rule.value.priority

      dynamic "override_action" {
        for_each = rule.value.override_action ? [1] : []

        content {
          count {}
        }
      }

      dynamic "override_action" {
        for_each = rule.value.override_action ? [] : [1]

        content {
          none {}
        }
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.rule_set_name
          vendor_name = rule.value.vendor_name

          dynamic "rule_action_override" {
            for_each = rule.value.excluded_rules

            content {
              action_to_use {
                count {}
              }

              name = rule_action_override.value
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = rule.value.cloudwatch_metrics_enabled
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = rule.value.sampled_requests_enabled
      }
    }
  }

  # Rate Limit Based Rules
  dynamic "rule" {
    for_each = var.rate_limit_rules

    content {
      name     = rule.key
      priority = rule.value.priority

      dynamic "action" {
        for_each = rule.value.action == "count" ? [1] : []

        content {
          count {}
        }
      }

      dynamic "action" {
        for_each = rule.value.action == "block" ? [1] : []

        content {
          block {}
        }
      }

      statement {
        rate_based_statement {
          limit              = rule.value.limit
          aggregate_key_type = rule.value.aggregate_key_type

          dynamic "scope_down_statement" {
            for_each = length(rule.value.geo_matches) > 0 ? [1] : []

            content {
              geo_match_statement {
                country_codes = each.value
              }
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = rule.value.cloudwatch_metrics_enabled
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = rule.value.sampled_requests_enabled
      }
    }
  }

  dynamic "rule" {
    for_each = var.restrict_country_code_rules

    content {
      name     = rule.key
      priority = rule.priority

      dynamic "action" {
        for_each = rule.value.action == "count" ? [1] : []

        content {
          count {}
        }
      }

      dynamic "action" {
        for_each = rule.value.action == "block" ? [1] : []

        content {
          block {}
        }
      }

      statement {
        geo_match_statement {
          country_codes = rule.country_codes
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = rule.value.cloudwatch_metrics_enabled
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = rule.value.sampled_requests_enabled
      }
    }
  }

  dynamic "rule" {
    for_each = var.rule_groups

    content {
      name     = rule.value.name
      priority = rule.value.priority

      dynamic "override_action" {
        for_each = rule.value.override_action ? [1] : []

        content {
          count {}
        }
      }

      dynamic "override_action" {
        for_each = rule.value.override_action ? [] : [1]

        content {
          none {}
        }
      }

      statement {
        rule_group_reference_statement {
          arn = rule.value.rule_group_arn

          dynamic "excluded_rule" {
            for_each = rule.value.excluded_rules

            content {
              name = excluded_rule.value
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = rule.value.cloudwatch_metrics_enabled
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = rule.value.sampled_requests_enabled
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.acl_cloudwatch_metrics_enabled
    metric_name                = coalesce(var.acl_metric_name, "${local.name}-metric")
    sampled_requests_enabled   = var.acl_sampled_requests_enabled
  }

  tags = var.tags
}

resource "aws_wafv2_web_acl_association" "this" {
  count = var.create && length(var.resource_arn) > 0 ? 1 : 0

  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this[count.index].arn
}

resource "aws_wafv2_web_acl_logging_configuration" "this" {
  count = var.create ? 1 : 0

  log_destination_configs = [aws_kinesis_firehose_delivery_stream.this[count.index].arn]
  resource_arn            = aws_wafv2_web_acl.this[count.index].arn
}
