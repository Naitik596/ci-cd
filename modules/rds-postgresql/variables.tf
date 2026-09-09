	variable "name" {
	  description = "Name tag for all resources"
	  type        = string
	}

	variable "create_db_instance" {
	  description = "Master toggle for DB instance creation"
	  type        = bool
	  default     = true
	}

	variable "allocated_storage" {
	  description = "The allocated storage capacity for the database in gibibytes (GiB)"
	  type        = number
	  default     = 20

	  validation {
	    condition     = var.allocated_storage >= 20
	    error_message = "allocated_storage must be at least 20 GiB."
	  }
	}

	variable "max_allocated_storage" {
	  description = "Maximum storage capacity for autoscaling"
	  type        = number
	  default     = 100
	}

	variable "instance_class" {
	  description = "The instance type for the database"
	  type        = string
	  default     = "db.t3.micro"
	}

	variable "engine" {
	  description = "The database engine to use"
	  type        = string
	  default     = "postgres"
	}

	variable "engine_version" {
	  description = "The engine version to use"
	  type        = string
	  default     = null
	}

	variable "username" {
	  description = "Username for the master DB user"
	  type        = string
	  sensitive   = true
	}

	variable "password" {
	  description = "Password for the master DB user"
	  type        = string
	  sensitive   = true
	  default     = null
	}

	variable "environment" {
	  description = "Select environment type: dev, demo, prod"
	  type        = string
	  default     = "dev"
	}

	variable "storage_encrypted" {
	  description = "Specifies whether the DB instance is encrypted"
	  type        = bool
	  default     = true
	}

	variable "kms_key_arn" {
	  description = "ARN of KMS key for encryption"
	  type        = string
	  default     = null
	}

	variable "vpc_id" {
	  description = "VPC ID for security group and subnet group"
	  type        = string
	}

	variable "subnet_ids" {
	  description = "List of subnet IDs for DB subnet group"
	  type        = list(string)
	}

	variable "tags" {
	  description = "Tags applied to all resources"
	  type        = map(string)
	  default     = {}
	}

	variable "db_instance_tags" {
	  description = "Additional tags for the DB instance"
	  type        = map(string)
	  default     = {}
	}

	variable "db_subnet_group_tags" {
	  description = "Additional tags for subnet group"
	  type        = map(string)
	  default     = {}
	}

	variable "parameter_group_tags" {
	  description = "Additional tags for parameter group"
	  type        = map(string)
	  default     = {}
	}

	variable "security_group_tags" {
	  description = "Additional tags for security group"
	  type        = map(string)
	  default     = {}
	}
