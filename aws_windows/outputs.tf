// Print instance publiv ip
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.microsoft_server_2016.public_ip
}

/*
// Print instance id
output "my_instance_id" {
  description = "Instance id"
  value       = aws_instance.microsoft_server_2016.ami
}
*/

// Print RDP password
output "password_data" {
  description = "RDP password"
  value       = rsadecrypt(aws_instance.microsoft_server_2016.password_data, file("/Path/to/key/my_key.pem"))  
}