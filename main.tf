resource "aws_instance" "day1" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.deployer.key_name
    vpc_security_group_ids = [aws_security_group.web-sg.id]
    user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install nginx -y
                systemctl start nginx 
                systemctl enable nginx
                EOF
    tags = {
      Name = "day1-ec2"
    }
  
}

resource "aws_key_pair" "deployer" {
  key_name = "terraform-key"
  public_key = file(terraform-key.pub)
}

resource "aws_security_group" "web-sg" {
  name = "aws-web-sg"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}