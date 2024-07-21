variable "components" {
  default = ["frontend", "catalogue", "cart", "user", "shipping", "payment", "dispatch"]
}

resource "aws_instance" "instance" {
  count                  = length(var.components)
  ami                    = "ami-031da9bb5f8457ab4"
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0605b31229658744d"]
  tags = {
    Name = var.components[count.index]
  }
}

resource "aws_route53_record" "record" {
  count   = length(var.components)
  name    = var.components[count.index]
  type    = "A"
  zone_id = "Z0591896LOE9TNN6GUNS"
  records = [aws_instance.instance[count.index].private_ip]
  ttl     = 3
}


module "vpc" {
  source = "./modules/vpc"

  availability_zones     = var.availability_zones
  backend_subnets        = var.backend_subnets
  db_subnets             = var.db_subnets
  default_route_table_id = var.default_route_table_id
  default_vpc_cidr       = var.default_vpc_cidr
  default_vpc_id         = var.default_vpc_id
  env                    = var.env
  frontend_subnets       = var.frontend_subnets
  public_subnets         = var.public_subnets
  vpc_cidr_block         = var.vpc_cidr_block
}

module "docdb" {
  source   = "./modules/docdb"

  env                     = var.env
  family                  = var.docdb_family
  instance_class          = var.docdb_instance_class
  instance_count          = var.docdb_instance_count
  master_password         = "Roboshop12345"
  master_username         = "admin1"
  server_app_port_sg_cidr = var.backend_subnets
  subnet_ids              = module.vpc.db_subnets
  vpc_id                  = module.vpc.vpc_id
}

