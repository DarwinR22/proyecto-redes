# 🔢 AMI a utilizar (por ejemplo, Amazon Linux 2 o Ubuntu)
variable "ami_id" {
  description = "ID de la AMI a utilizar para la instancia EC2 (Amazon Linux 2)"
  type        = string
}

# 🌐 Subred donde se desplegará la instancia (debe ser pública si se quiere acceso externo)
variable "subnet_id" {
  description = "ID de la subred pública donde se desplegará el servidor web"
  type        = string
}

# 🏛️ VPC asociada a la subred
variable "vpc_id" {
  description = "ID de la VPC donde se encuentra la subred"
  type        = string
}

# 🔐 Clave SSH necesaria para conectarse vía terminal
variable "key_name" {
  description = "Nombre de la clave SSH para acceder a la instancia EC2"
  type        = string
}
