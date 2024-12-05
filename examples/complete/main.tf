provider "aws" {
  region = local.region
}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-west-1"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-wafv2"
    GithubOrg  = "dave-elkins"
  }
}

module "wafv2" {
  source = "../.."

  name         = local.name
  scope        = "REGIONAL"
  s3_bucket_id = "some_bucket_id"

  acl_cloudwatch_metrics_enabled = true
  acl_metric_name                = "${local.name}-metric"
  acl_sampled_requests_enabled   = false
  # use managed_rule_sets
  # use rate_limit_rules
  # use restrict_country_code_rules
  # use rule_groups

  # use resource_arn ... create ALB

  tags = local.tags
}

# show with create = false
