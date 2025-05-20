# 🏛️ ID de la VPC donde se desplegarán los recursos de red (Internet Gateway, subredes, rutas)
variable "vpc_id" {
  description = "ID de la VPC donde se crearán las subredes y la tabla de rutas"
  type        = string
}

# 🌐 CIDR de la subred pública (ejemplo: 10.0.1.0/24)
variable "public_subnet_cidr" {
  description = "Rango CIDR asignado a la subred pública (debe estar dentro del bloque CIDR de la VPC)"
  type        = string
}

# 🔐 CIDR de la subred privada (ejemplo: 10.0.2.0/24)
variable "private_subnet_cidr" {
  description = "Rango CIDR asignado a la subred privada (debe estar dentro del bloque CIDR de la VPC)"
  type        = string
}

# 📍 Zona de disponibilidad (ejemplo: us-east-1a)
variable "availability_zone" {
  description = "Zona de disponibilidad en la que se crearán las subredes"
  type        = string
}
