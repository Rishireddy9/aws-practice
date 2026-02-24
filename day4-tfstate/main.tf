provider "aws" {
  region = "ap-south-1"
}
resource "aws_s3_bucket" "terraform-state" {
  bucket = "rishi-terraform-state-12345"
  tags = {
    Name = "Terraform state files"
  }
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "tf-state" {
  bucket = aws_s3_bucket.terraform-state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-locks" {
  name = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}