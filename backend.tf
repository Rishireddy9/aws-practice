terraform {
  backend "s3" {
    bucket = "rishi-terraform-state-12345"
    key = "ec2/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
    
  }
}