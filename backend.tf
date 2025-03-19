terraform {
  backend "s3" {
    bucket = "loadbalance1-project-bucket"  # Replace with your unique S3 bucket name
    key    = "files/key/terraform.tfstate"  # Path inside the bucket to store the state
    region = "ap-southeast-2"
    encrypt = true  # Enable encryption of the state file
    dynamodb_table = "terraform-locks"
 
   
  }
}
