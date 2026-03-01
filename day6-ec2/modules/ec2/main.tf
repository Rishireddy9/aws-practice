resource "aws_security_group" "sgt" {
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.environment}-sgt"
  }
}
resource "aws_key_pair" "terraform-key" {
  key_name = "terraform-key"
  public_key = file("E:/Aws-devops-practice/day6-ec2/terraform-key.pub")
}
resource "aws_instance" "pub-1-instance" {
  ami = "ami-051a31ab2f4d498f5"
  instance_type = var.intance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sgt.id]
  key_name = aws_key_pair.terraform-key.key_name
  user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install nginx -y
            systemctl start nginx
            systemctl enable nginx
            EOF
    tags = {
        Name = "${var.environment}-instance"
    }

}