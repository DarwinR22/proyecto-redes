# 🧱 AMI base (Ubuntu 22.04 por ejemplo)
variable "ami_id" {
  description = "AMI para Ubuntu"
  type        = string
}

# 🖥️ Tipo de instancia (t2.micro por defecto)
variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

# 🌐 Subred donde se desplegará el IDS
variable "subnet_id" {
  description = "ID de la subred para la instancia IDS"
  type        = string
}

# 🏛️ VPC a la que pertenece la subred
variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

# 🔐 Clave SSH para acceso remoto
variable "key_name" {
  description = "Nombre de la clave SSH"
  type        = string
}

# 🏷️ Etiquetas opcionales
variable "tags" {
  description = "Etiquetas aplicadas a la instancia"
  type        = map(string)
  default     = {}
}
