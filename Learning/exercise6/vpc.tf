resource "aws_vpc" "multi-resource-vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "vprofile"
  }
}//"aws_vpc" "multi-resource-vpc"

///////////////////////PUBLIC SUBNET///////////////////////////
resource "aws_subnet" "pub-subnet-1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.multi-resource-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = var.ZONE-USE1a
  tags = {
    Name = "pub-subnet-1"
  }
}//pub-subnet-1

resource "aws_subnet" "pub-subnet-2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.multi-resource-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = var.ZONE-USE1b
  tags = {
    Name = "pub-subnet-2"
  }
}//pub-subnet-2

resource "aws_subnet" "pub-subnet-3" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.multi-resource-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = var.ZONE-USE1c
  tags = {
    Name = "pub-subnet-3"
  }
}//pub-subnet-3

//////////////////PRIVATE SUBNET///////////////////
resource "aws_subnet" "priv-subnet-1" {
  cidr_block = "10.0.4.0/24"
  vpc_id = aws_vpc.multi-resource-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = var.ZONE-USE1a
  tags = {
    Name = "priv-subnet-1"
  }
}//priv-subnet-1

resource "aws_subnet" "priv-subnet-2" {
  cidr_block = "10.0.5.0/24"
  vpc_id = aws_vpc.multi-resource-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = var.ZONE-USE1b
  tags = {
    Name = "priv-subnet-2"
  }
}//priv-subnet-2

resource "aws_subnet" "priv-subnet-3" {
  cidr_block = "10.0.6.0/24"
  vpc_id = aws_vpc.multi-resource-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = var.ZONE-USE1c
  tags = {
    Name = "priv-subnet-3"
  }
}//priv-subnet-3

///////////////////////////////INTERNET GATEWAY///////////////////////////
resource "aws_internet_gateway" "multiresource-IGW" {
  vpc_id = aws_vpc.multi-resource-vpc.id
  tags = {
    Name = "multiresource-IGW"
  }
}//mulriresource-IGW

////////////////////////////ROUTING TABLE/////////////////////////////////////
resource "aws_route_table" "multiresource-pub-RT" {
  vpc_id = aws_vpc.multi-resource-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.multiresource-IGW.id
  }

  tags = {
    Name = "multiresource-pub-RT"
  }
}//mulriresource-pub-RT

resource "aws_route_table_association" "mulriresource-pub-1" {
  subnet_id = aws_subnet.pub-subnet-1.id
  route_table_id = aws_route_table.multiresource-pub-RT.id
}//mulriresource-pub-1

resource "aws_route_table_association" "mulriresource-pub-2" {
  subnet_id = aws_subnet.pub-subnet-2.id
  route_table_id = aws_route_table.multiresource-pub-RT.id
}//mulriresource-pub-2

resource "aws_route_table_association" "multiresource-pub-3" {
  subnet_id = aws_subnet.pub-subnet-3.id
  route_table_id = aws_route_table.multiresource-pub-RT.id
}//mulriresource-pub-3