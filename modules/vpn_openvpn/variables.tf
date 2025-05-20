# 💻 Tipo de instancia EC2 a usar (t2.micro recomendado para pruebas con VNS3 Free)
variable "instance_type" {
  description = "Tipo de instancia EC2 para VNS3 (t2.micro o t3.micro para Free Tier)"
  type        = string
  default     = "t2.micro"
}

# 🌐 Subred donde se desplegará la instancia VNS3 (debe ser pública)
variable "subnet_id" {
  description = "ID de la subred pública donde se desplegará VNS3"
  type        = string
}

# 🏛️ VPC a la que pertenece la instancia
variable "vpc_id" {
  description = "ID de la VPC donde vive la instancia VNS3"
  type        = string
}

# 🔐 Par de llaves SSH para acceso al servidor
variable "key_name" {
  description = "Nombre del par de llaves SSH para acceso remoto"
  type        = string
}

# 🏷️ Etiquetas personalizadas para la instancia (como Environment, Owner, etc.)
variable "tags" {
  description = "Etiquetas adicionales para la instancia"
  type        = map(string)
  default     = {}
}

# 🧱 AMI oficial de VNS3 (se especifica desde el archivo dev.tfvars o root module)
variable "openvpn_ami_id" {
  description = "AMI para la instancia VNS3 (pasada desde dev.tfvars)"
  type        = string
}
