module "network" {
  source = "../Network"
}//module "Network"

resource "random_id" "random" {
  byte_length = 15
}

resource "aws_s3_bucket" "my-web-app-test-s3"{
  #dejansko ime za bucket na AWS-u. na koncu dodamo nek ramdom string
  bucket = "web-app-test-s3-${random_id.random.hex}"
  tags = {
    Name = "Web app test S3"
    Purpose = "S3 bucket for internal web app"
  }//tags
}//"aws_s3_bucket" "my-web-app-test-s3"

resource "aws_s3_bucket_ownership_controls" "my-web-app-test-acl" {
  bucket = aws_s3_bucket.my-web-app-test-s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }//rule
}//"aws_s3_bucket_ownership_controls" "my-web-app-test-acl"


