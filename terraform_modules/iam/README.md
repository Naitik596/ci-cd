# IAM Module

Production-ready IAM module for Lambda least-privilege access to S3 (read) and DynamoDB (write).

## Usage

```hcl
module "lambda_iam" {
  source = "./terraform_modules/iam"

  name = "lambda-s3-dynamodb-access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:GetObject", "s3:ListBucket"]
        Resource = ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
      },
      {
        Effect = "Allow"
        Action = ["dynamodb:PutItem", "dynamodb:UpdateItem"]
        Resource = "arn:aws:dynamodb:us-east-1:123456789012:table/my-table"
      }
    ]
  })

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name for the IAM role and policy | string | — | yes |
| create_iam_role | Whether to create the IAM role | bool | `true` | no |
| create_iam_policy | Whether to create the IAM policy | bool | `true` | no |
| create_iam_role_policy_attachment | Whether to attach the policy to the role | bool | `true` | no |
| assume_role_policy | JSON policy document for Lambda assume role | string | `null` | no |
| policy | JSON policy document for least-privilege S3 read and DynamoDB write | string | `null` | no |
| description | Description of the IAM role and policy | string | `IAM role/policy for Lambda least-privilege access to S3 and DynamoDB` | no |
| tags | Tags to apply to all resources | map(string) | `{}` | no |
| iam_role_tags | Additional tags for the IAM role | map(string) | `{}` | no |
| iam_policy_tags | Additional tags for the IAM policy | map(string) | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_arn | ARN of the created IAM role |
| policy_arn | ARN of the created IAM policy |
| role_name | Name of the IAM role |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.7 |
| aws | ~> 6.64.0 |
