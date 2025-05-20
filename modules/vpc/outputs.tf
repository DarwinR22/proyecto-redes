# ✅ Exporta el ID de la VPC para que pueda ser usado por otros módulos
output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.this.id
}
