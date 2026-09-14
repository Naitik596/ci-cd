output "role_arn" {
  description = "ARN of the created IAM role"
  value       = try(aws_iam_role.this[0].arn, null)
}

output "policy_arn" {
  description = "ARN of the created IAM policy"
  value       = try(aws_iam_policy.this[0].arn, null)
}

output "role_name" {
  description = "Name of the IAM role"
  value       = try(aws_iam_role.this[0].name, null)
}

output "policy_name" {
  description = "Name of the IAM policy"
  value       = try(aws_iam_policy.this[0].name, null)
}
