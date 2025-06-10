variable "instance_id" {
  description = "ID de la instancia EC2 a la que se asigna la EIP"
  type        = string
}

variable "name" {
  description = "Nombre de recurso para tag Name"
  type        = string
  default     = "web-server-eip"
}

variable "project" {
  description = "Tag Project"
  type        = string
  default     = "redesYa"
}

variable "environment" {
  description = "Tag Env (dev/prod)"
  type        = string
}

variable "cost_center" {
  description = "Tag CostCenter"
  type        = string
  default     = "SECNET"
}

variable "extra_tags" {
  description = "Tags adicionales para el recurso"
  type        = map(string)
  default     = {}
}
