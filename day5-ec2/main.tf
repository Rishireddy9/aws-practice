resource "aws_vpc" "web-app" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "web-app-vpc"
  }
}
resource "aws_subnet" "web-app-public-subnet" {
  vpc_id = aws_vpc.web-app.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "web-app-public-subnet"
  }
}
resource "aws_internet_gateway" "web-app-ig" {
  vpc_id = aws_vpc.web-app.id
}
resource "aws_route_table" "web-app-rt" {
  vpc_id = aws_vpc.web-app.id
}
resource "aws_route" "web-app-route" {
  route_table_id = aws_route_table.web-app-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.web-app-ig.id
}
resource "aws_route_table_association" "web-app-rt-ass" {
  subnet_id = aws_subnet.web-app-public-subnet.id
  route_table_id = aws_route_table.web-app-rt.id
}
resource "aws_security_group" "web-app-sg" {
  name = "web-app-sg"
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
}
resource "aws_key_pair" "terraform-key" {
  key_name = "terraform-key"
  public_key = file(terraform-key.pub)
}
resource "aws_instance" "web-app-instance" {
    subnet_id = aws_subnet.web-app-public-subnet.id
    ami = var.ami-id
    vpc_security_group_ids = [aws_security_group.web-app-sg.id]
    key_name = aws_key_pair.terraform-key.key_name
    instance_type = var.instance-type
    user_data = <<-EOF
                yum update -y
                yum install nginx -y
                systemctl start nginx
                systemctl enable nginx
                EOF
  
}