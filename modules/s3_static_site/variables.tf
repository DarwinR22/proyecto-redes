variable "bucket_name" {
  description = "Nombre único del bucket S3 para el sitio estático"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (por ejemplo: dev o prod)"
  type        = string
}

variable "project" {
  description = "Etiqueta del proyecto (tag Project)"
  type        = string
  default     = "redesYa"
}

variable "cost_center" {
  description = "Centro de costos (tag CostCenter)"
  type        = string
  default     = "SECNET"
}

variable "owner" {
  description = "Propietario del recurso (tag Owner)"
  type        = string
  default     = "Darwin Lopez"
}

variable "extra_tags" {
  description = "Etiquetas adicionales opcionales"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "Región AWS donde se desplegará el sitio"
  type        = string
}
