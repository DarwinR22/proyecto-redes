# =================
# 🌐 SERVIDOR WEB
# =================
output "web_server_public_ip" {
  description = "Dirección IP pública del servidor web"
  value       = module.web_server.public_ip
}

output "web_server_instance_id" {
  description = "ID de la instancia EC2 del servidor web"
  value       = module.web_server.instance_id
}

# ==============================
# 🏢 SERVIDOR DE DOMINIO (AD DS)
# ==============================
output "domain_controller_public_ip" {
  description = "Dirección IP pública del servidor de dominio"
  value       = module.domain_controller.public_ip
}

output "domain_controller_instance_id" {
  description = "ID de la instancia del servidor de dominio"
  value       = module.domain_controller.instance_id
}

output "domain_controller_private_ip" {
  description = "IP privada del servidor de dominio"
  value       = module.domain_controller.private_ip
}

# ==================
# 🛡️ IDS / IPS SERVER
# ==================
output "ids_public_ip" {
  description = "Dirección IP pública del servidor IDS"
  value       = module.ids.ids_public_ip
}

output "ids_instance_id" {
  description = "ID de la instancia del servidor IDS"
  value       = module.ids.ids_instance_id
}

# =========================
# 🗂️ SITIO ESTÁTICO EN S3
# =========================
output "static_site_url" {
  description = "URL pública del sitio web estático alojado en S3"
  value       = "http://${module.static_site.website_endpoint}"
}

# ================================
# 🔐 VPN - VNS3 CONTROLLER (FIREWALL)
# ================================
output "vns3_public_ip" {
  description = "IP pública del servidor VPN (VNS3)"
  value       = module.vpn.vns3_public_ip
}

output "vns3_private_ip" {
  description = "IP privada del servidor VPN (VNS3)"
  value       = module.vpn.vns3_private_ip
}
