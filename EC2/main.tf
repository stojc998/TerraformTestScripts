resource "aws_instance" "ec2_instances" {
  ami = var.ami
  instance_type = var.instance_size
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_groups

  tags = {
    "Name" = "TEST-SERVER"
    "Environment" = "TEST"
  }//tags
}//resource "aws_instance" "ec2_instances"