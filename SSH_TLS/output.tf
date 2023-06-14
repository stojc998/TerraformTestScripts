output "ssh_key_name" {
  #izpisem vpc id da ga lahk potem referenciriram v drugi datoteki
  value = aws_key_pair.my_keypair.key_name
}//output "vpc_id

output "tls_key_name" {
  value = tls_private_key.generate_key.private_key_pem
}
