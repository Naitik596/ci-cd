output "log_group_arn" {
  description = "The Amazon Resource Name (ARN) of the CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.this.arn
}

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the KMS key."
  value       = aws_kms_key.this.arn
}
