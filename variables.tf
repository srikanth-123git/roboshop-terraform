variable "availability_zones" {}
variable "backend_subnets" {}
variable "db_subnets" {}
variable "default_route_table_id" {}
variable "default_vpc_cidr" {}
variable "default_vpc_id" {}
variable "env" {}
variable "frontend_subnets" {}
variable "public_subnets" {}
variable "vpc_cidr_block" {}

variable "docdb" {}
variable "rds" {}
variable "rabbitmq" {}
variable "elasticache" {}

variable "vault_token" {}
variable "kms_key_id" {}

variable "bastion_nodes" {}
variable "prometheus_nodes" {}


variable "instance_type" {}
variable "max_capacity" {}
variable "min_capacity" {}
variable "certificate_arn" {}
variable "zone_id" {}

