# 🧱 AMI base para Ubuntu (Suricata)
variable "ami_id" {
  description = "AMI ID para la instancia IDS (Ubuntu 22.04)"
  type        = string
}

# 🖥️ Tipo de instancia EC2
variable "instance_type" {
  description = "Tipo de instancia EC2 (p.ej., t2.micro)"
  type        = string
  default     = "t2.micro"
}

# 🌐 Subred donde desplegar el IDS (privada o publica segun diseño)
variable "subnet_id" {
  description = "ID de la subred para la instancia IDS"
  type        = string
}

# 🏛️ VPC ID
variable "vpc_id" {
  description = "ID de la VPC donde se encuentra la subred"
  type        = string
}

# 🔐 Clave SSH para acceso administrativo
variable "key_name" {
  description = "Nombre del par de llaves SSH para acceder al IDS"
  type        = string
}

# 🔑 IPs permitidas para SSH
variable "admin_ip" {
  description = "CIDR con la IP publica del administrador (ej: \"190.14.138.134/32\")"
  type        = string
}

variable "firewall_ip" {
  description = "CIDR con la IP/EIP del appliance VNS3 (firewall/VPN)"
  type        = string
}

# 📂 Etiquetado
variable "environment" {
  description = "Entorno de despliegue (dev/prod)"
  type        = string
}

variable "project" {
  description = "Nombre del proyecto para la etiqueta Project"
  type        = string
  default     = "redesYa"
}

variable "cost_center" {
  description = "Codigo de CostCenter"
  type        = string
  default     = "SECNET"
}

variable "owner" {
  description = "Propietario/Responsable del recurso"
  type        = string
  default     = "Darwin Lopez "
}

variable "extra_tags" {
  description = "Tags adicionales opcionales para aplicar"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  type = string
}

variable "cw_log_group" {
  type = string
}
