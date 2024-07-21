variable "components" {
  default = ["frontend", "catalogue", "cart", "user", "shipping", "payment", "dispatch", "mongodb", "mysql", "rabbitmq", "redis"]
}

resource "aws_instance" "instances" {
  count                  = length(var.components)
  ami                    = "ami-031da9bb5f8457ab4"
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0605b31229658744d"]
  tags = {
    Name = var.components[count.index]
  }
}
