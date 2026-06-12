output "public_ip" {
  value       = aws_instance.cse632_vm.public_ip
  description = "Public IP of the NGINX server"
}

output "public_dns" {
  value       = aws_instance.cse632_vm.public_dns
  description = "Public DNS of the NGINX server"
}

output "ssh_command" {
  value       = "ssh -i ~/cse632-key.pem ec2-user@${aws_instance.cse632_vm.public_ip}"
  description = "SSH command to connect"
}
