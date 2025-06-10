# modules/vns3_firewall/outputs.tf

output "vns3_public_ip" {
  description = "IP publica de la instancia VNS3"
  value       = aws_instance.vns3.public_ip
}

output "vns3_private_ip" {
  description = "IP privada de la instancia VNS3"
  value       = aws_instance.vns3.private_ip
}

output "vns3_ui_url" {
  description = "URL de acceso a la UI de VNS3"
  value       = "https://${aws_instance.vns3.public_ip}:8000"
}

output "security_group_id" {
  description = "ID del Security Group de VNS3"
  value       = aws_security_group.vns3_sg.id
}

output "vns3_instance_id" {
  value = aws_instance.vns3.id
}
