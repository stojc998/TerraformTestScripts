output "vpc_id" {
  #izpisem vpc id da ga lahk potem referenciriram v drugi datoteki
  value = aws_vpc.vpc.id
}//output "vpc_id

output "sg-ssh" {
  value = aws_security_group.ssh-aces.id
}//sg-ssh

output "sg-web" {
  value = aws_security_group.web-aces.id
}//sg-ssh

#PUBLIC SUBNETS
output "subnet1-dev-pub" {
  value = aws_subnet.public_subnets[1].id
}//output "subnet1-dev-pub"

output "subnet2-test-pub" {
  value = aws_subnet.public_subnets[2].id
}//output "subnet2-test-pub"

output "subnet3-prod-pub" {
  value = aws_subnet.public_subnets[3].id
}//output "subnet3-prod-pub"

#PRIVATE SUBNET
output "subnet1-dev-pri" {
  value = aws_subnet.private_subnets[1].id
}//output "subnet1-dev-pri"

output "subnet2-test-pri" {
  value = aws_subnet.private_subnets[2].id
}//output "subnet2-test-pri"

output "subnet3-prod-pri" {
  value = aws_subnet.private_subnets[3].id
}//output "subnet3-prod-pri"