# 🌐 IP publica para conectarse via RDP
output "public_ip" {
  description = "IP publica para acceder al servidor Windows via RDP"
  value       = aws_instance.windows.public_ip
}

# 🆔 ID unico de la instancia EC2
output "instance_id" {
  description = "ID de la instancia EC2 del servidor Windows"
  value       = aws_instance.windows.id
}

# 🔐 IP privada fija usada para comunicacion con otros modulos (LDAP, DNS)
output "private_ip" {
  description = "IP privada fija del servidor de dominio (usada para LDAP y resolucion interna)"
  value       = aws_instance.windows.private_ip
}
