resource "aws_security_group" "main" {
  name        = "${var.component}-${var.env}-sg"
  description = "${var.component}-${var.env}-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "TCP"
    cidr_blocks = var.server_app_port_sg_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

resource "aws_docdb_cluster_parameter_group" "main" {
  name   = "${var.component}-${var.env}-pg"
  family = var.family
}

resource "aws_docdb_subnet_group" "main" {
  name       = "${var.component}-${var.env}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.component}-${var.env}-subnet-group"
  }
}

resource "aws_docdb_cluster" "main" {
  cluster_identifier              = "${var.env}-cluster"
  engine                          = "docdb"
  master_username                 = var.master_username
  master_password                 = var.master_password
  backup_retention_period         = 5
  preferred_backup_window         = "07:00-09:00"
  skip_final_snapshot             = true
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.main.name
  db_subnet_group_name            = aws_docdb_subnet_group.main.name
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.instance_count
  identifier         = "${var.env}-cluster-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = var.instance_class
}

