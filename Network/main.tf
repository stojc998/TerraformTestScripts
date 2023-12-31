#configure the AWS provider
provider "aws" {
  region = var.aws_region
}

#retrive the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

#define the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
    Environment = "Demo_environment"
    Terraform = "true"
  }//tags
}//aws_vpc" "vpc

#Deploy the private subnet
resource "aws_subnet" "private_subnets" {
  //for_each = var.private_subnets
  for_each = var.subnet_types
  vpc_id = aws_vpc.vpc.id
  //cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value)
  cidr_block = each.value.ip_private
  //availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]
  availability_zone = each.value.az_private

  tags = {
    Name = each.key
    Terraform = "true"
  }//tags
}//"aws_subnet" "private_subnets"

#Deploy the public subnet
resource "aws_subnet" "public_subnets" {
  //for_each = var.public_subnets
  for_each = var.subnet_types
  vpc_id = aws_vpc.vpc.id
  //cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  cidr_block = each.value.ip_public
  //availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]
  availability_zone = each.value.az_public
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
    Terraform = "true"
  }//tags
}//"aws_subnet" "public_subnets"

#Create rout tables for public and private subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
    #nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }//route

  tags = {
    Name = "Public route table"
    Terraform = "true"
  }//tags
}//"aws_route_table" "public_rout_table"

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #gateway_id = aws_internet_gateway.internet_gateway.id
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }//route

  tags = {
    Name = "Private route table"
    Terraform = "true"
  }//tags
}//"aws_route_table" "private_rout_table"

#Create route table associations
resource "aws_route_table_association" "public" {
  depends_on = [aws_subnet.public_subnets]
  route_table_id = aws_route_table.public_route_table.id
  for_each = aws_subnet.public_subnets
  subnet_id = each.value.id
}//"aws_route_table_association" "public"

resource "aws_route_table_association" "private" {
  depends_on = [aws_subnet.private_subnets]
  route_table_id = aws_route_table.private_route_table.id
  for_each = aws_subnet.private_subnets
  subnet_id = each.value.id
}//"aws_route_table_association" "private"

#Create internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Internet Gateway"
  }//tags
}//"aws_internet_gateway" "internet_gateway"

#Create EIP for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  #vpc = true #deprecitive
  domain = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "Internet Gateway EIP"
  }//tags
}//"aws_eip" "nat_gateway_eip"

#Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [aws_subnet.public_subnets]
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id = aws_subnet.public_subnets["test_public_subnet"].id

  tags = {
    Name = "NAT GAteway"
  }//tags
}//"aws_nat_gateway" "nat_gateway"

#Create security groups. These are basic SV that can be used in lots of cases
resource "aws_security_group" "ssh-aces" {
  name = "allow-ssh-from-myip"
  vpc_id = aws_vpc.vpc.id
  ingress {
    #cidr_blocks = ["0.0.0.0/0"]//I have put this just for the sake of it. In the configuration that I have run I put my actual public IP
    cidr_blocks = [var.my_public_ip] #we intput our public IP
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }//ingress SSH

}//resource "aws_security_group" "ssh-aces"

resource "aws_security_group" "web-aces" {
  name = "allow-web-from-myIP"
  vpc_id = aws_vpc.vpc.id
  ingress {
    #cidr_blocks = ["0.0.0.0/0"]//I have put this just for the sake of it. In the configuration that I have run I put my actual public IP
    cidr_blocks = [var.my_public_ip]
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }//ingress web 80

  ingress {
    cidr_blocks = [var.my_public_ip]
    from_port = 443
    protocol = "tcp"
    to_port = 443
  }//ingress web 443

}//resource "aws_security_group" "ssh-aces"
