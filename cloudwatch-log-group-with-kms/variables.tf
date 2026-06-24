variable "log_group_name" {
  description = "Name of the CloudWatch Log Group."
  type        = string
  default     = "/aws/lambda/demo"
}

variable "retention_in_days" {
  description = "Number of days to retain log events."
  type        = number
  default     = 14
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    "Environment" = "staging"
    "Compliance"  = "SOC2"
    "ManagedBy"   = "Terraform"
  }
}
