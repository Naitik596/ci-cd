output "arn" {
  description = "ARN of the bucket."
  value       = try(aws_s3_bucket.this[0].arn, null)
}

output "bucket_domain_name" {
  description = "Bucket domain name."
  value       = try(aws_s3_bucket.this[0].bucket_domain_name, null)
}

output "id" {
  description = "Name of the bucket."
  value       = try(aws_s3_bucket.this[0].id, null)
}

output "bucket_regional_domain_name" {
  description = "Regional domain name of the bucket."
  value       = try(aws_s3_bucket.this[0].bucket_regional_domain_name, null)
}
