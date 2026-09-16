variable "name" {
	  description = "Name tag for all resources"
	  type        = string
	}

	variable "create_s3_bucket" {
	  description = "Master toggle for S3 bucket creation"
	  type        = bool
	  default     = true
	}



	variable "bucket" {
	  description = "Name of the bucket. If omitted, Terraform will assign a random, unique name"
	  type        = string
	  default     = null
	}

	variable "versioning" {
	  description = "Versioning configuration block"
	  type = object({
	    enabled = bool
	  })
	  default = {
	    enabled = true
	  }
	}

	variable "server_side_encryption_configuration" {
	  description = "Server-side encryption configuration for the bucket"
	  type = object({
	    rule = object({
	      apply_server_side_encryption_by_default = object({
	        sse_algorithm = string
	      })
	    })
	  })
	  default = {
	    rule = {
	      apply_server_side_encryption_by_default = {
	        sse_algorithm = "aws:kms"
	      }
	    }
	  }
	}

	variable "block_public_access" {
	  description = "Public access block configuration"
	  type = object({
	    block_public_acls       = bool
	    block_public_policy     = bool
	    ignore_public_acls      = bool
	    restrict_public_buckets = bool
	  })
	  default = {
	    block_public_acls       = true
	    block_public_policy     = true
	    ignore_public_acls      = true
	    restrict_public_buckets = true
	  }
	}

	variable "region" {
	  description = "Region where the resource(s) will be managed"
	  type        = string
	  default     = "us-east-1"
	}

	variable "tags" {
	  description = "Tags applied to all resources"
	  type        = map(string)
	  default     = {}
	}

	variable "s3_bucket_tags" {
	  description = "Additional tags for the S3 bucket"
	  type        = map(string)
	  default     = {}
	}