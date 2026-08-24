# terraform-aws-s3-versioning/outputs.tf
output "bucket_id" {
  description = "The unique ID of the S3 bucket."
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN for the newly created bucket (useful for policies, IAM)."
  value       = aws_s3_bucket.this.arn
}

output "versioning_enabled" {
  description = "True – versioning is permanently enabled on this bucket."
  value       = true
}
