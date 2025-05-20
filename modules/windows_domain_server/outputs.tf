# 🌐 IP pública para conectarse vía RDP
output "public_ip" {
  description = "IP pública para acceder al servidor Windows vía RDP"
  value       = aws_instance.windows.public_ip
}

# 🆔 ID único de la instancia EC2
output "instance_id" {
  description = "ID de la instancia EC2 del servidor Windows"
  value       = aws_instance.windows.id
}

# 🔐 IP privada fija usada para comunicación con otros módulos (LDAP, DNS)
output "private_ip" {
  description = "IP privada fija del servidor de dominio (usada para LDAP y resolución interna)"
  value       = aws_instance.windows.private_ip
}
