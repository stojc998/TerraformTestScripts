resource "aws_instance" "variables-inst" {
  ami = var.AMIS[var.REGION]
  instance_type = "t2.micro"
  availability_zone = var.ZONE1
  key_name = "terra-key"
  vpc_security_group_ids = ["sg-0b966d877b5ba1ef2"]
  tags = {
    Name = "Variables-Instance"
    Project = "Variables"
  }
}