output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = try(aws_s3_bucket.this.id, null)
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket."
  value       = try(aws_s3_bucket.this.arn, null)
}

output "s3_bucket_domain_name" {
  description = "The bucket domain name."
  value       = try(aws_s3_bucket.this.bucket_domain_name, null)
}

output "s3_bucket_regional_domain_name" {
  description = "The bucket region-specific domain name."
  value       = try(aws_s3_bucket.this.bucket_regional_domain_name, null)
}