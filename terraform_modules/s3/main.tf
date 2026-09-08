locals {
  bucket_name = var.bucket != null ? var.bucket : "${var.name}-bucket"
  common_tags = merge(
    {
      "Name"        = var.name
      "Environment" = "dev"
      "ManagedBy"   = "terraform"
    },
    var.tags
  )
}

resource "aws_s3_bucket" "this" {
  count = var.create_s3 ? 1 : 0

  bucket        = local.bucket_name
  force_destroy = var.force_destroy

  tags = merge(local.common_tags, { "Name" = local.bucket_name })
}

resource "aws_s3_bucket_versioning" "this" {
  count = var.create_s3 ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  versioning_configuration {
    status = lookup(var.versioning_configuration, "status", "Enabled")
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = var.create_s3 ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = lookup(var.server_side_encryption_configuration.rule.apply_server_side_encryption_by_default, "sse_algorithm", "aws:kms")
      kms_master_key_id = lookup(var.server_side_encryption_configuration.rule.apply_server_side_encryption_by_default, "kms_master_key_id", "")
    }
    bucket_key_enabled = lookup(var.server_side_encryption_configuration.rule, "bucket_key_enabled", true)
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.create_s3 ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  count = var.create_s3 && var.attach_deny_insecure_transport_policy ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyNonSSLRequests"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.this[0].arn,
          "${aws_s3_bucket.this[0].arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
