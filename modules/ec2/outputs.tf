# 📤 Muestra la IP pública de la instancia EC2 para acceder vía navegador o SSH
output "public_ip" {
  description = "Dirección IP pública de la instancia EC2 que actúa como servidor web"
  value       = aws_instance.web.public_ip
}

# 🆔 Identificador único de la instancia EC2 creada
output "instance_id" {
  description = "ID de la instancia EC2 del servidor web"
  value       = aws_instance.web.id
}

# 🛡️ ID del grupo de seguridad asociado, útil para debugging o referencias cruzadas
output "security_group_id" {
  description = "ID del Security Group asociado a la instancia web"
  value       = aws_security_group.web_sg.id
}
