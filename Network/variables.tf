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

  validation {
    condition = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.vpc_cidr))

    error_message = "Please enter a valid IP address. In a valid range."
  }//validation
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



