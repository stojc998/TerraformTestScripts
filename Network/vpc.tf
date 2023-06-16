module "vpc-test" {
  source = "terraform-aws-modules/vpc/aws"
  version = ">3.11.0"

  name = "test-vpc"
  cidr = "10.10.0.0/16"

  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Name = "VPC-module_test-vpc"
    Terraform = "true"
    Environment = "test"
  }//tags
}//module "vpc-test"