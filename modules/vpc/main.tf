# ✅ Crea una VPC con el bloque CIDR especificado por variable
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr                         # Rango de IPs privadas para la red (ej: 10.0.0.0/16)

  # Habilita soporte para nombres DNS dentro de la VPC (necesario para EC2, AD, etc.)
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "secure-vpc"                             # Etiqueta para identificar la VPC
  }
}
