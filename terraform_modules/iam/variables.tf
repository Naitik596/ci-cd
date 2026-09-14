variable "name" {
  description = "Name for the IAM role and policy"
  type        = string
}

variable "create_iam_role" {
  description = "Whether to create the IAM role"
  type        = bool
  default     = true
}

variable "create_iam_policy" {
  description = "Whether to create the IAM policy"
  type        = bool
  default     = true
}

variable "create_iam_role_policy_attachment" {
  description = "Whether to attach the policy to the role"
  type        = bool
  default     = true
}

variable "assume_role_policy" {
  description = "JSON policy document for Lambda assume role"
  type        = string
  default     = null
}

variable "policy" {
  description = "JSON policy document for least-privilege S3 read and DynamoDB write"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the IAM role and policy"
  type        = string
  default     = "IAM role/policy for Lambda least-privilege access to S3 and DynamoDB"
}

variable "force_detach_policies" {
  description = "Whether to force detaching any policies the role has before destroying it"
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds)"
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "iam_role_tags" {
  description = "Additional tags for the IAM role"
  type        = map(string)
  default     = {}
}

variable "iam_policy_tags" {
  description = "Additional tags for the IAM policy"
  type        = map(string)
  default     = {}
}
