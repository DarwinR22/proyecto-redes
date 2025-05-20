# 🆔 ID de la subred pública creada
output "public_subnet_id" {
  description = "ID de la subred pública creada"
  value       = aws_subnet.public.id
}

# 🆔 ID de la subred privada creada
output "private_subnet_id" {
  description = "ID de la subred privada creada"
  value       = aws_subnet.private.id
}
