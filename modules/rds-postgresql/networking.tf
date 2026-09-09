	resource "aws_db_subnet_group" "main" {
	  count = var.create_db_instance ? 1 : 0

	  name       = "${var.name}-subnet-group"
	  subnet_ids = var.subnet_ids

	  description = "DB subnet group for ${var.name}"

	  tags = merge(
	    { "Name" = "${var.name}-subnet-group" },
	    var.tags,
	    var.db_subnet_group_tags
	  )
	}
