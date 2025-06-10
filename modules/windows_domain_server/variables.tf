variable "ami_id" {
  description = "AMI de Windows Server 2019"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia para AD DS"
  type        = string
  default     = "t2.medium"
}

variable "subnet_id" {
  description = "ID de la subred donde se desplegara el controlador"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "key_name" {
  description = "Nombre del par de llaves para RDP"
  type        = string
}

variable "private_ip" {
  description = "IP privada fija para el controlador (ej: 10.0.1.145)"
  type        = string
}

# Nuevas variables para restricciones y etiquetado
variable "admin_ip" {
  description = "CIDR de la IP del administrador (ej: \"190.14.138.134/32\")"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block de la VPC (ej: \"10.0.0.0/16\")"
  type        = string
}

variable "domain_name" {
  description = "Nombre DNS del dominio a crear (ej: project-redes.local)"
  type        = string
}

variable "safe_mode_password" {
  description = "Contraseña Safe Mode para AD DS"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Entorno de despliegue (dev/prod)"
  type        = string
}

variable "project" {
  description = "Tag Project"
  type        = string
  default     = "redesYa"
}

variable "cost_center" {
  description = "Tag CostCenter"
  type        = string
  default     = "SECNET"
}

variable "owner" {
  description = "Tag Owner"
  type        = string
  default     = "Darwin Lopez "
}

variable "extra_tags" {
  description = "Tags adicionales opcionales"
  type        = map(string)
  default     = {}
}
