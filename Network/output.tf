output "vpc_id" {
  #izpisem vpc id da ga lahk potem referenciriram v drugi datoteki
  value = aws_vpc.vpc.id
}//output "vpc_id