data "aws_iam_policy_document" "kms" {
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid = "Allow CloudWatch Logs to use the key"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
    ]
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
    resources = ["*"]
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_kms_key" "this" {
  description             = "KMS key for CloudWatch Log Group ${var.log_group_name}"
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms.json
  deletion_window_in_days = 7

  tags = merge(
    {
      "Name" = "${var.log_group_name}-kms-key"
    },
    var.tags,
  )
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.log_group_name}-kms-key"
  target_key_id = aws_kms_key.this.key_id
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = aws_kms_key.this.arn

  tags = merge(
    {
      "Name" = var.log_group_name
    },
    var.tags,
  )
}
