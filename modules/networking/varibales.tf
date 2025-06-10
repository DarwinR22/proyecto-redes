variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR principal de la VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR de la subred pública"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR de la subred privada"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidad (ej: us-east-1a)"
  type        = string
}

variable "environment" {
  description = "Nombre del entorno (dev, prod)"
  type        = string
}

variable "extra_tags" {
  description = "Tags adicionales"
  type        = map(string)
  default     = {}
}

variable "admin_ip" {
  description = "CIDR de la IP del administrador (ej: 190.14.138.134/32)"
  type        = string
}

variable "firewall_ip" {
  description = "CIDR de la IP del firewall (por ejemplo, la IP de VNS3)"
  type        = string
}
