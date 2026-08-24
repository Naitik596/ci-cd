# terraform-aws-s3-versioning/variables.tf
variable "bucket_name" {
  description = "The name of the bucket (must be globally unique)."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources in this module."
  type        = map(string)
  default     = {}
}
