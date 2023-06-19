terraform {

  #this is done by default in  Terraform
  /*backend "local" {
    path = "terraform.tfstate"
  }//backend "local"*/

  #we store our state file in a s3 bucket. It's going to create prod in in that a file prod/aws_infra
  backend "s3" {
    bucket = TERRAFORM_LOCK_BUCKET #using exports
    key = TERRAFORM_LOCK_KEY
    region = "us-east-1a"

    #locking mechanism
    dynamodb_table = TERRAFORM_DYNAMO_TABLE
    encrypt = true
  }//backend "local"

  required_version = ">=1.4.0"
  #required_version = "=1.5.0"//mora bit taksna verzija
  #required_version = "~>1.5.0"//tilda. pomeni da je najbol desna stevilka je lahk spremenljiva
  required_providers {
    aws = {
          source = "hashicorp/aws"
          version = "~> 5.2.0" //zahtevamo verzijo 5.2.0 ali vecje 5.2.0
    }//aws

    http = {
      source =  "hashicorp/http"
      version = "3.3.0"
    }//http

    random = {
      source =  "hashicorp/random"
      version = "3.5.1"
    }//random

    //is used to manage local resources, such as files.
    local = {
      source =  "hashicorp/local"
      version = "2.4.0"
    }//local

    tls = {
      source = "hashicorp/tls"
      version = "4.0.4" //zelo posreceno :-)
    }//tls
  }//required_providers
}//terraform
