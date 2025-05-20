# 🆔 ID de la instancia EC2 donde corre el IDS
output "ids_instance_id" {
  value = aws_instance.ids.id
}

# 🌐 IP pública del IDS (para acceder vía SSH y monitorear Suricata)
output "ids_public_ip" {
  value = aws_instance.ids.public_ip
}
