output "public_subnet_id" {
  description = "ID de la subred pública"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID de la subred privada"
  value       = aws_subnet.private.id
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  description = "ID de la tabla de rutas privada"
  value       = aws_route_table.private_rt.id
}

output "nat_eip_allocation_id" {
  description = "Allocation ID del EIP para NAT"
  value       = aws_eip.nat.id
}
