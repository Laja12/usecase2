terraform {
  backend "s3" {
    bucket = "bucket-for-threetier"  # Replace with your unique S3 bucket name
    key    = "terraform/key/terraform.tfstate"  # Path inside the bucket to store the state
    encrypt = true  # Enable encryption of the state file
   
  }
}
