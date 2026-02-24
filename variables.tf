variable "region" {
  description = "aws region"
  type = string
  default = "ap-south-1"
}
variable "instance_type" {
  description = "ec2 instance type"
  type = string
  default = "t2.micro"
}
variable "ami_id" {
  description = "ami-id"
  type = string
}