# ✅ Bloque CIDR que define el rango de direcciones IP internas de la VPC
variable "vpc_cidr" {
  description = "CIDR block para la VPC (ej: 10.0.0.0/16)"
  type        = string
}

variable "environment" { 
  description = "Entorno (dev/prod)" 
  type = string 
  }

variable "extra_tags" { 
  description = "Tags adicionales" 
  type = map(string) 
  default = {} 
}
