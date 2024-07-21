data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "golden-ami-*"
  owners      = ["self"]
}
