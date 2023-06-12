variable "aws_region" {
  type = string
  default = "us-east-1"
}//aws_regin

variable "vpc_name" {
  type = string
  default = "demo_vpc"
}//vpc_name

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}//vpc_cidr

variable "private_subnets" {
  default = {
    "dev_private_subnet" = 1
    "test_private_subnet" = 2
    "production_private_subnet" = 3
  }//default
}//private_subnets

variable "public_subnets" {
  default = {
    "dev_public_subnet" = 1
    "test_public_subnet" = 2
    "production_public_subnet" = 3
  }//default
}//public_subnets



