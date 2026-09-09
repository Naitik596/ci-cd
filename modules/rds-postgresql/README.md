	# RDS PostgreSQL Terraform Module

	Production-ready AWS RDS PostgreSQL module for dev with Single-AZ, encryption, and TLS enforcement.

	## Usage

	```hcl
	module "rds_postgresql" {
	  source = "./modules/rds-postgresql"

	  name        = "myapp-db"
	  username    = "dbadmin"
	  password    = var.db_password
	  vpc_id      = "vpc-12345678"
	  subnet_ids  = ["subnet-aaa", "subnet-bbb"]

	  tags = {
	    Environment = "dev"
	    Team        = "backend"
	  }
	}
	```

	## Requirements

	| Name | Version |
	|------|---------|
	| terraform | >= 1.5.0 |
	| aws | ~> 6.63.0 |

	## Inputs

	| Name | Description | Type | Default | Required |
	|------|-------------|------|---------|----------|
	| name | Name tag for all resources | `string` | n/a | yes |
	| create_db_instance | Master toggle for DB instance creation | `bool` | `true` | no |
	| allocated_storage | Allocated storage in GiB | `number` | `20` | no |
	| max_allocated_storage | Maximum storage for autoscaling | `number` | `100` | no |
	| instance_class | DB instance class | `string` | `db.t3.micro` | no |
	| engine | Database engine | `string` | `postgres` | no |
	| engine_version | Engine version | `string` | `null` | no |
	| username | Master DB username | `string` | n/a | yes |
	| password | Master DB password | `string` | `null` | no |
	| environment | Environment (dev/demo/prod) | `string` | `dev` | no |
	| storage_encrypted | Enable storage encryption | `bool` | `true` | no |
	| kms_key_arn | KMS key ARN for encryption | `string` | `null` | no |
	| vpc_id | VPC ID | `string` | n/a | yes |
	| subnet_ids | Subnet IDs for DB subnet group | `list(string)` | n/a | yes |
	| tags | Tags for all resources | `map(string)` | `{}` | no |
	| db_instance_tags | Additional tags for DB instance | `map(string)` | `{}` | no |
	| db_subnet_group_tags | Additional tags for subnet group | `map(string)` | `{}` | no |
	| parameter_group_tags | Additional tags for parameter group | `map(string)` | `{}` | no |
	| security_group_tags | Additional tags for security group | `map(string)` | `{}` | no |

	## Outputs

	| Name | Description |
	|------|-------------|
	| endpoint | RDS instance endpoint |
	| arn | RDS instance ARN |
	| db_instance_id | RDS instance identifier |
	| security_group_id | Security group ID |
	| subnet_group_name | DB subnet group name |

	## License

	MIT
