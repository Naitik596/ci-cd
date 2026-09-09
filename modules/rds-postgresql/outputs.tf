	output "endpoint" {
	  description = "RDS instance endpoint"
	  value       = try(aws_db_instance.main[0].endpoint, null)
	  depends_on  = [aws_db_instance.main]
	}

	output "arn" {
	  description = "RDS instance ARN"
	  value       = try(aws_db_instance.main[0].arn, null)
	  depends_on  = [aws_db_instance.main]
	}

	output "db_instance_id" {
	  description = "RDS instance identifier"
	  value       = try(aws_db_instance.main[0].id, null)
	  depends_on  = [aws_db_instance.main]
	}

	output "security_group_id" {
	  description = "Security group ID"
	  value       = try(aws_security_group.main[0].id, null)
	}

	output "subnet_group_name" {
	  description = "DB subnet group name"
	  value       = try(aws_db_subnet_group.main[0].name, null)
	}
