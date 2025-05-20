# 📦 AMI base de Windows Server (ej. Windows Server 2019 Base)
variable "ami_id" {
  description = "AMI de Windows Server"
  type        = string
}

# 🖥️ Tipo de instancia EC2 (t2.medium recomendado para Active Directory)
variable "instance_type" {
  description = "Tipo de instancia para el servidor de dominio"
  type        = string
  default     = "t2.medium"
}

# 🌐 Subred en la que se desplegará la instancia
variable "subnet_id" {
  description = "ID de la subred donde se alojará el servidor Windows"
  type        = string
}

# 🏛️ VPC a la que pertenece la subred
variable "vpc_id" {
  description = "ID de la VPC del servidor Windows"
  type        = string
}

# 🔐 Nombre del par de llaves SSH/RDP
variable "key_name" {
  description = "Nombre de la clave SSH para acceder (usado con RDP)"
  type        = string
}

# 🏷️ Etiquetas adicionales para la instancia
variable "tags" {
  description = "Etiquetas adicionales para la instancia"
  type        = map(string)
  default     = {}
}
