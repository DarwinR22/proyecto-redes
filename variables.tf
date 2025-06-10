# 🌍 Region AWS
variable "region" {
  description = "Region donde se desplegaran los recursos"
  type        = string
  default     = "us-east-1"
}

# 🔐 Clave SSH para EC2
variable "key_name" {
  description = "Nombre del par de llaves SSH"
  type        = string
}

# 📦 AMIs necesarias
variable "web_ami_id" {
  description = "AMI para servidor web (Amazon Linux, etc.)"
  type        = string
}
variable "windows_ami_id" {
  description = "AMI para Windows Server 2019"
  type        = string
}
variable "ubuntu_ami_id" {
  description = "AMI para Ubuntu (para IDS)"
  type        = string
}
variable "openvpn_ami_id" {
  description = "AMI de VNS3 o OpenVPN"
  type        = string
}

# 🧱 VPC y subredes
variable "vpc_cidr" {
  description = "CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR para subred publica"
  type        = string
  default     = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
  description = "CIDR para subred privada"
  type        = string
  default     = "10.0.2.0/24"
}
variable "availability_zone" {
  description = "Zona de disponibilidad AWS"
  type        = string
  default     = "us-east-1a"
}

# 🏷️ Etiquetas globales
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}
variable "project" {
  description = "Nombre del proyecto"
  type        = string
  default     = "redesYa"
}
variable "cost_center" {
  description = "Centro de costos"
  type        = string
  default     = "SECNET"
}
variable "owner" {
  description = "Responsable"
  type        = string
  default     = "Darwin Lopez "
}
variable "extra_tags" {
  description = "Tags adicionales"
  type        = map(string)
  default     = {}
}

# 🛡️ Seguridad y VPN
variable "admin_ip" {
  description = "IP del administrador (ej: \"190.14.138.134/32\")"
  type        = string
}
variable "vpn_client_cidr" {
  description = "CIDR de clientes VPN (por defecto: abierto)"
  type        = string
  default     = "0.0.0.0/0"
}

# 🏢 Dominio de Windows Server
variable "domain_name" {
  description = "Nombre del dominio AD DS"
  type        = string
  default     = "project-redes.local"
}
variable "safe_mode_password" {
  description = "Contraseña para el modo seguro de AD"
  type        = string
  sensitive   = true
}

# 🛡️ IDS y CloudWatch
variable "ids_instance_type" {
  description = "Tipo de instancia para IDS (Suricata)"
  type        = string
  default     = "t2.micro"
}
variable "firewall_instance_type" {
  description = "Tipo de instancia para VNS3/OpenVPN"
  type        = string
  default     = "t2.micro"
}
variable "cw_log_group" {
  description = "Grupo de logs en CloudWatch para Suricata"
  type        = string
  default     = "/aws/suricata/ids"
}

variable "vpn_client_ip" {
  description = "IP del cliente en la red VPN (WireGuard)"
  type        = string
  default     = "10.0.3.2/32"
}

variable "windows_instance_type" {
  description = "Tipo de instancia EC2 para Windows AD"
  type        = string
  default     = "t2.medium"
}

variable "vpn_server_ip" {
  description = "IP privada que usará el servidor VPN"
  type        = string
  default     = "10.0.3.1/32"
}

variable "domain_controller_private_ip" {
  description = "IP privada fija para el servidor de dominio"
  type        = string
}

variable "firewall_ami_id" {
  description = "AMI para el firewall (VNS3 u OpenVPN)"
  type        = string
}

variable "firewall_ip" {
  description = "Dirección IP privada del firewall o VPN server"
  type        = string
}
