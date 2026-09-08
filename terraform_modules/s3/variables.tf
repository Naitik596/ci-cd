variable "name" {
  description = "Name tag for all resources"
  type        = string
}

variable "create_s3" {
  description = "Master toggle to create S3 resources"
  type        = bool
  default     = true
}

variable "bucket" {
  description = "Name of the bucket. Must be lowercase and follow S3 naming rules."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Boolean that indicates all objects should be deleted from the bucket when destroyed."
  type        = bool
  default     = false
}

variable "versioning_configuration" {
  description = "Configuration block for S3 bucket versioning."
  type        = any
  default     = { status = "Enabled" }
}

variable "server_side_encryption_configuration" {
  description = "Configuration for server-side encryption using KMS CMK."
  type        = any
  default = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = ""
      }
      bucket_key_enabled = true
    }
  }
}

variable "attach_deny_insecure_transport_policy" {
  description = "Controls if S3 bucket should have deny non-SSL transport policy attached."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
