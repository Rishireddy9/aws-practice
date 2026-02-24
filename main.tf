resource "aws_instance" "day1" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
      Name = "day1-ec2"
    }
  
}