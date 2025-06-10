# modules/vns3_firewall/variables.tf

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subred publica para VNS3"
  type        = string
}

variable "openvpn_ami_id" {
  description = "AMI ID para el VNS3 appliance (Marketplace)"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para VNS3 (p.ej., t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre del par de llaves SSH"
  type        = string
}

variable "admin_ip" {
  description = "CIDR con la IP del administrador (p.ej., \"190.14.138.134/32\")"
  type        = string
}

variable "vpn_client_cidr" {
  description = "CIDR con el rango de IPs permitidas para WireGuard (p.ej., \"10.0.3.0/24\")"
  type        = string
}

variable "vpn_server_ip" {
  description = "IP interna del servidor VPN (p.ej., \"10.0.3.1/24\")"
  type        = string
}

variable "vpn_client_ip" {
  description = "IP interna asignada al cliente en WireGuard (p.ej., \"10.0.3.2/32\")"
  type        = string
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
