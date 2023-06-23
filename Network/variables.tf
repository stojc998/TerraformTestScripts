module "vault" {
  source = "../vault"
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}//aws_regin

variable "vpc_name" {
  type = string
  default = "demo_vpc"
}//vpc_name

variable "my_public_ip" {
  type = string
  #default = data.vault_generic_secret.vault-secrets.data["my_public_ip"] //pure chance that the variable name is the same as the key name in vault
  default = module.vault.public_ip //pure chance that the variable name is the same as the key name in vault
  sensitive = true
  validation {
    condition = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.vpc_cidr))
    error_message = "Please enter a valid IP address. In a valid range."
  }//validation
}//"my_public_ip"

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

variable "subnet_types" {
  type = map(any)
  default = {
    dev = {
      ip_private = "10.10.10.0/24"
      az_private = "us-east-1a"
      ip_public = "10.10.110.0/24"
      az_public = "us-east-1a"
    }//dev

    test = {
      ip_private = "10.10.20.0/24"
      az_private = "us-east-1b"
      ip_public = "10.10.120.0/24"
      az_public = "us-east-1b"
    }//test

    prod = {
      ip_private = "10.10.30.0/24"
      az_private = "us-east-1c"
      ip_public = "10.10.130.0/24"
      az_public = "us-east-1c"
    }//prod
  }//default
}//"subnet-types"



