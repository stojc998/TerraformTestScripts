variable "REGION" {
  default = "us-east-1"
}

variable "ZONE-USE1a" {
  default = "us-east-1a"
}

variable "ZONE-USE1b" {
  default = "us-east-1b"
}

variable "ZONE-USE1c" {
  default = "us-east-1c"
}

variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-00c39f71452c08778"
  }
}

variable "USER" {
  default = "ec2-user" //default user od amazon linux za ssh dostop v tem primeru
}

variable "PUB_KEY" {
  default = "multi-resource.pub"
}

variable "PRIV_KEY" {
  default = "multi-resource"
}

variable "MYIP" {
  default = "86.58.117.250/32"
}