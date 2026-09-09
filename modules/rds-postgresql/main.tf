	resource "aws_db_instance" "main" {
	  count = var.create_db_instance ? 1 : 0

	  allocated_storage     = var.allocated_storage
	  max_allocated_storage = var.max_allocated_storage
	  engine                = var.engine
	  engine_version        = var.engine_version
	  instance_class        = var.instance_class
	  username              = var.username
	  password              = var.password
	  storage_encrypted     = var.storage_encrypted
	  kms_key_id            = var.kms_key_arn

	  auto_minor_version_upgrade  = true
	  apply_immediately           = true
	  allow_major_version_upgrade = false

	  parameter_group_name   = aws_db_parameter_group.main[0].name
	  db_subnet_group_name   = aws_db_subnet_group.main[0].name
	  vpc_security_group_ids = [aws_security_group.main[0].id]

	  tags = merge(
	    { "Name" = var.name },
	    var.tags,
	    var.db_instance_tags
	  )

	  depends_on = [
	    aws_db_subnet_group.main,
	    aws_db_parameter_group.main,
	    aws_security_group.main
	  ]
	}

	resource "aws_db_parameter_group" "main" {
	  count = var.create_db_instance ? 1 : 0

	  name   = "${var.name}-pg"
	  family = "postgres16"

	  description = "Parameter group for ${var.name}"

	  parameter {
	    name  = "log_connections"
	    value = "1"
	  }

	  parameter {
	    name  = "log_disconnections"
	    value = "1"
	  }

	  tags = merge(
	    { "Name" = "${var.name}-pg" },
	    var.tags,
	    var.parameter_group_tags
	  )
	}
