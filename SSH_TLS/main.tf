resource "tls_private_key" "generate_key" {
  algorithm = "RSA"
}//recource "tls_private_key" "generate_key"

resource "local_file" "private_key_pem" {
  content = tls_private_key.generate_key.private_key_pem
  filename = ""
}//resource "local_file" "private_key_pem"
