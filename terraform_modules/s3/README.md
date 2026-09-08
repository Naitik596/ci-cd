# S3 Module

Production-ready AWS S3 bucket module with KMS encryption, versioning, public access blocks, and secure transport policy.

## Usage

```hcl
module "s3_bucket" {
  source = "./terraform_modules/s3"

  name   = "my-app-bucket"
  bucket = "my-unique-bucket-name"

  tags = {
    Environment = "dev"
    Project     = "my-project"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name tag for all resources | `string` | n/a | yes |
| create_s3 | Master toggle to create S3 resources | `bool` | `true` | no |
| bucket | Name of the bucket | `string` | `null` | no |
| force_destroy | Delete all objects on destroy | `bool` | `false` | no |
| versioning_configuration | Versioning config | `any` | `{'status': 'Enabled'}` | no |
| server_side_encryption_configuration | KMS encryption config | `any` | KMS with bucket key | no |
| attach_deny_insecure_transport_policy | Enforce TLS | `bool` | `true` | no |
| tags | Tags for all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN of the bucket |
| bucket_domain_name | Bucket domain name |
| id | Bucket name |
| bucket_regional_domain_name | Regional domain name |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| aws | ~> 6.63.0 |
