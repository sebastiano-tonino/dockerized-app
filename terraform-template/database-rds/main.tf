resource "aws_db_subnet_group" "rds_subnets" {
    name       = "${var.name_prefix}-db-subnet-group"
    subnet_ids = var.db_subnet_ids
    tags = {
        Name = "${var.name_prefix}-db-subnet-group"
        Client     = var.common_tags["Client"]
        Project    = var.common_tags["Project"]
        Stage      = var.common_tags["Stage"]
        DevOpsTool = var.common_tags["DevOpsTool"]
    }
}

resource "aws_security_group" "rds_sg" {
    name_prefix = "${var.name_prefix}-rds-sg"
    description = "Allow access to DB ${var.name_prefix}"
    vpc_id      = var.vpc_id

    ingress {
        description = "MariaDB"
        from_port   = var.db_port
        to_port     = var.db_port
        protocol    = "tcp"
        cidr_blocks = var.allowed_cidr_blocks
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.name_prefix}-rds-sg"
        Client     = var.common_tags["Client"]
        Project    = var.common_tags["Project"]
        Stage      = var.common_tags["Stage"]
        DevOpsTool = var.common_tags["DevOpsTool"]
    }
}

resource "aws_db_instance" "mariadb" {
    identifier = "${var.name_prefix}-mariadb"

    engine            = "mariadb"
    engine_version    = var.engine_version
    instance_class    = var.instance_class

    username                      = var.db_username
    manage_master_user_password   = true

    db_subnet_group_name = aws_db_subnet_group.rds_subnets.name
    vpc_security_group_ids  = [aws_security_group.rds_sg.id]
    allocated_storage       = var.allocated_storage
    storage_type            = var.storage_type

    backup_retention_period = var.backup_retention_period
    backup_window           = var.backup_window
    deletion_protection     = var.deletion_protection

    multi_az              = var.multi_az
    skip_final_snapshot   = var.skip_final_snapshot
    publicly_accessible   = var.publicly_accessible
    deletion_protection   = var.deletion_protection

    tags = {
        Name       = "${var.name_prefix}-mariadb"
        Client     = var.common_tags["Client"]
        Project    = var.common_tags["Project"]
        Stage      = var.common_tags["Stage"]
        DevOpsTool = var.common_tags["DevOpsTool"]
    }
}