# 🌍 IP pública de la instancia VNS3 (para acceso web/SSH)
output "vns3_public_ip" {
  description = "IP pública de la instancia VNS3"
  value       = aws_instance.vns3.public_ip
}

# 🔐 IP privada (para ruteo dentro de la VPC)
output "vns3_private_ip" {
  description = "IP privada de la instancia VNS3 (útil para routing interno)"
  value       = aws_instance.vns3.private_ip
}
