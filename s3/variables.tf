variable "bucket_name" {
  description = "The name of the S3 bucket. If not provided, a random name will be generated."
  type        = string
  default     = "talkops-test-bucket-mehak"
}

variable "versioning_enabled" {
  description = "If true, versioning will be enabled for the S3 bucket."
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Configuration for the S3 bucket public access block."
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}

variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration. Overridden by kms_key_arn if provided."
  type        = any
  default = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for server-side encryption. If provided, this overrides the default AES256 encryption."
  type        = string
  default     = null
}

variable "lifecycle_rules" {
  description = "A list of maps representing lifecycle rules for the bucket."
  type        = any
  default     = []
}

variable "logging" {
  description = "Configuration for S3 server access logging."
  type = object({
    target_bucket = string
    target_prefix = string
  })
  default = null
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error."
  type        = bool
  default     = false
}

variable "enforce_tls_only" {
  description = "If true, a bucket policy will be attached to deny requests that do not use TLS (HTTPS)."
  type        = bool
  default     = true
}

variable "bucket_policy" {
  description = "A valid bucket policy JSON document. This will be merged with other generated policies like the TLS enforcement policy."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}