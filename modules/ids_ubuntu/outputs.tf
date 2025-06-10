#########################################
# Outputs
#########################################
output "ids_instance_id" {
  description = "ID de la instancia IDS"
  value       = aws_instance.ids.id
}

output "ids_public_ip" {
  description = "IP publica de la instancia IDS"
  value       = aws_instance.ids.public_ip
}