resource "aws_security_group" "multiresource-sg" {
  vpc_id = aws_vpc.multi-resource-vpc.id
  name = "multiresource-stack-sg"
  description = "Security group for multiresource exercise"

  //outbound trafic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }//egress

  //inbound trafic
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [var.MYIP]
    description = "Allow ssh trafic from my IP"
  }//ingress ssh

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = [var.MYIP]
    description = "Allow http trafic from my IP"
  }//ingress http
}//multiresource-sg