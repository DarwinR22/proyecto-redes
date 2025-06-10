# 📤 Muestra la IP publica de la instancia EC2 para acceder via navegador o SSH
output "public_ip" {
  description = "Direccion IP publica de la instancia EC2 que actua como servidor web"
  value       = aws_instance.web.public_ip
}

# 🆔 Identificador unico de la instancia EC2 creada
output "instance_id" {
  description = "ID de la instancia EC2 del servidor web"
  value       = aws_instance.web.id
}

# 🛡️ ID del grupo de seguridad asociado, util para debugging o referencias cruzadas
output "security_group_id" {
  description = "ID del Security Group asociado a la instancia web"
  value       = aws_security_group.web_sg.id
}


