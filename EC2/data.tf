data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }//filter ubuntu

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }//filter
  owners = []
}//data "aws_ami" "ubuntu"