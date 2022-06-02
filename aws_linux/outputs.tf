output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.debian.public_ip
}

output "my_instance_id" {
  description = "Instance id"
  value       = aws_instance.debian.ami
}