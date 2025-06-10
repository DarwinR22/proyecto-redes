output "allocation_id" {
  description = "ID de asignacion de la EIP"
  value       = aws_eip.this.allocation_id
}

output "public_ip" {
  description = "Direccion IP publica asignada"
  value       = aws_eip.this.public_ip
}
