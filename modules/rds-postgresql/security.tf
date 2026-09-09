	resource "aws_security_group" "main" {
	  count = var.create_db_instance ? 1 : 0
	
	  name        = "${var.name}-sg"
	  description = "Security group for RDS PostgreSQL instance ${var.name}"
	  vpc_id      = var.vpc_id
	
	  ingress {
	    description = "PostgreSQL from VPC"
	    from_port   = 5432
	    to_port     = 5432
	    protocol    = "tcp"
	    cidr_blocks = ["10.0.0.0/8"]
	  }
	
	  egress {
	    description = "Allow all outbound"
	    from_port   = 0
	    to_port     = 0
	    protocol    = "-1"
	    cidr_blocks = ["0.0.0.0/0"]
	  }
	
	  tags = merge(
	    { "Name" = "${var.name}-sg" },
	    var.tags,
	    var.security_group_tags
	  )
	}