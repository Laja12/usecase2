resource "aws_s3_bucket" "example" {
  bucket = "bucket-for-threetier"
  


  tags = {
    Name        = "My bucket"
    
  }
}