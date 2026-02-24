resource "aws_instance" "day1" {
    ami = "ami-051a31ab2f4d498f5"
    instance_type = "t2.micro"
    tags = {
      Name = "day1-ec2"
    }
  
}