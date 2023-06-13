terraform {
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
