# ✅ Exporta el ID de la VPC para que pueda ser usado por otros modulos
output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.this.id
}
