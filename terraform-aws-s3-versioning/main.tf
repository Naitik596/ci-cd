# terraform-aws-s3-versioning/main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Optional: enforce a specific AWS region at the module level
  required_version = ">= 1.6.0"
}

provider "aws" {
  # The caller's root configuration typically supplies credentials/region.
  # Keeping it here makes the module self‑contained when tested in isolation.
  region = var.region
}

/* ------------------------------------------------------------------
   S3 bucket – a modern, secure, versioned bucket.
   - Use the official AWS provider resource.
   - Enable Object Versioning (recommended for backup & recovery).
   - Turn on server‑side encryption with Amazon‑managed KMS keys.
   - Add a lifecycle rule to transition old versions to Glacier after 365 days
     (cost‑effective archival) and delete non‑current versions after 180 days.
   - Disable public ACLs – we use bucket policies instead if needed.
   - Enable MFA Delete only if you have an IAM user with the rights to do so;
     most teams leave it disabled for simplicity.
------------------------------------------------------------------- */

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  # Explicitly set ACL – we avoid granting public access unless requested
  acl    = "private"

  tags = merge(
    {
      Name        = var.bucket_name
      ManagedBy   = "terraform"
      Environment = try(var.environment, "unknown")
    },
    var.tags,
  )
}

/* ---- Versioning --------------------------------------------------- */
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

/* ---- Server‑Side Encryption (SSE‑KMS) ------------------------------ */
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id   # <- default to your account's CMK
      sse_algorithm     = "aws:kms"
    }
    bucketsize = ["Large"]   # optional – just for readability in docs
  }

  depends_on = [aws_s3_bucket.this]
}

/* ---- Lifecycle Rules ------------------------------------------------ */
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "archive-and-cleanup"
    enabled = true
    filter {}
    status      = "Enabled"

    # Transition *any* object (including versioned ones) to Glacier after one year
    transition {
      days          = 365
      storage_class = "GLACIER"
      class         = "STANDARD_IA"   # keep Standard-IA for the first 30‑90 days if you wish
    }

    # Delete non‑current (old) versions after 180 days to keep costs low
    non_current_version_expiration {
      days = 180
    }

    # Delete all *current* object versions that are older than 365 days.
    # This does NOT affect the most recent version, which stays.
    expiration {
      days = 365
    }
  }

  depends_on = [aws_s3_bucket_versioning.this]
}

/* ---- Optional Object Lock (WORM) ----------------------------------- */
// Uncomment and set `object_lock_enabled = true` in the bucket resource if you need immutable storage.

