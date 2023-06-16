provider "aws" {
  region = "us-east-1"
  //access_key = ""//je doloceno prek aws cli
  //secret_key = ""//much more secure :-)
}

//instance type and instance name
resource "aws_instance" "intro" {
  ami = "ami-00c39f71452c08778" //id od amazon linux
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "terra-key"
  vpc_security_group_ids = ["sg-0b966d877b5ba1ef2"]
  tags = {
    Name = "Terraform 1. instance"
  }
}