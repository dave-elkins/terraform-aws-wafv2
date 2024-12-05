data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create ? 1 : 0

  name               = "${local.name}-firehose-delivery-role"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_id}",
      "arn:aws:s3:::${var.s3_bucket_id}/*"
    ]
  }
}

resource "aws_iam_role_policy" "this" {
  count = var.create ? 1 : 0

  name   = "${local.name}-firehose-delivery-role-policy"
  role   = aws_iam_role.this[count.index].id
  policy = data.aws_iam_policy_document.this.json
}
