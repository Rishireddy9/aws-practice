output "public_ip" {
    value = aws_instance.day1.public_ip
  
}
output "instance-id" {
  value = aws_instance.day1.id
}