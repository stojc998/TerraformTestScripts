resource "tls_private_key" "generate_key" {
  algorithm = "RSA"
}//recource "tls_private_key" "generate_key"

resource "local_file" "private_key_pem" {
  content = tls_private_key.generate_key.private_key_pem
  filename = "MyTestSSH_Key-20230613.pem"
}//resource "local_file" "private_key_pem"

resource "aws_key_pair" "my_keypair" {
  key_name = "MyTestSSH_Key-20230613"
  public_key = tls_private_key.generate_key.public_key_openssh

  lifecycle {
    ignore_changes = [key_name]
  }//lifecycle
}//resource "aws_key_pair" "my_keypair"
