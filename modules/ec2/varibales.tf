# 🔢 AMI a utilizar (por ejemplo, Amazon Linux 2 o Ubuntu)
variable "ami_id" {
  description = "ID de la AMI a utilizar para la instancia EC2 (Amazon Linux 2)"
  type        = string
}

# 🌐 Subred donde se desplegara la instancia (debe ser publica si se quiere acceso externo)
variable "subnet_id" {
  description = "ID de la subred publica donde se desplegara el servidor web"
  type        = string
}

# 🏛️ VPC asociada a la subred
variable "vpc_id" {
  description = "ID de la VPC donde se encuentra la subred"
  type        = string
}

# 🔐 Clave SSH necesaria para conectarse via terminal
variable "key_name" {
  description = "Nombre de la clave SSH para acceder a la instancia EC2"
  type        = string
}

variable "environment" {
  description = "Entorno (dev/prod)"
  type        = string
}

variable "project" {
  description = "Nombre del proyecto para tag Project"
  type        = string
  default     = "redesYa"
}

variable "cost_center" {
  description = "Codigo de CostCenter"
  type        = string
  default     = "SECNET"
}

variable "owner" {
  description = "Dueño del recurso"
  type        = string
  default     = "Darwin Lopez"
}

variable "extra_tags" {
  description = "Tags adicionales opcionales"
  type        = map(string)
  default     = {}
}
