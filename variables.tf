# 🌍 Región donde se desplegarán los recursos
variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

# 🔐 Nombre del par de llaves SSH
variable "key_name" {
  description = "Nombre de la llave SSH"
  type        = string
}

# 🏷️ Etiquetas generales
variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default     = {}
}

# 💾 Tamaño del volumen raíz (no se usa directamente, pero útil si lo necesitas)
variable "volume_size" {
  description = "Tamaño del volumen raíz en GB"
  type        = number
  default     = 30
}

# 🌐 Parámetros opcionales para EC2
variable "associate_public_ip_address" {
  description = "Asociar una IP pública a la instancia"
  type        = bool
  default     = true
}

variable "monitoring" {
  description = "Activar monitoreo detallado en la instancia"
  type        = bool
  default     = false
}

# 📦 AMIs para cada tipo de servidor
variable "web_ami_id" {
  description = "AMI para el servidor web EC2"
  type        = string
}

variable "firewall_ami_id" {
  description = "AMI para pfSense o firewall Linux"
  type        = string
}

variable "windows_ami_id" {
  description = "AMI de Windows Server"
  type        = string
}

variable "ubuntu_ami_id" {
  description = "AMI de Ubuntu Server"
  type        = string
}

# 🖥️ Tipo de instancia para VPN/Firewall
variable "firewall_instance_type" {
  description = "Tipo de instancia para el firewall"
  type        = string
  default     = "t2.micro"
}

# 🔒 AMI personalizada con OpenVPN o VNS3
variable "openvpn_ami_id" {
  description = "AMI personalizada con OpenVPN preconfigurado"
  type        = string
}
