resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.environment}-vpc"
  }
}
resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.environment}-public-subnet"
  }
}
resource "aws_internet_gateway" "igt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-igt"
  }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-rt"
  }
}
resource "aws_route" "pub-route" {
  route_table_id = aws_route_table.rt.id
  gateway_id = aws_internet_gateway.igt.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route_table_association" "pub-association" {
  subnet_id = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.rt.id
}
