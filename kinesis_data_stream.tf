locals {
  s3_path_prefix = "awswafv2/${local.name}"
}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  count = var.create ? 1 : 0

  name        = "aws-waf-logs-${local.name}"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.this[count.index].arn
    bucket_arn = "arn:aws:s3:::${var.s3_bucket_id}"
    prefix     = local.s3_path_prefix
  }

  tags = var.tags
}
