output "instance-id" {
  value = aws_instance.web-app-instance.id
}
output "public_ip" {
  value = aws_instance.web-app-instance.public_ip
}