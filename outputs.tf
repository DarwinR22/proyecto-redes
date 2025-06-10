// root/outputs.tf limpio y funcional

// ────────────────────────────────────
// 🌐 VPC & Networking
// ────────────────────────────────────
output "vpc_id" {
  description = "ID de la VPC principal"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID de la subred publica"
  value       = module.networking.public_subnet_id
}

output "private_subnet_id" {
  description = "ID de la subred privada"
  value       = module.networking.private_subnet_id
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = module.networking.nat_gateway_id
}

output "nat_gateway_eip" {
  description = "Elastic IP del NAT Gateway"
  value       = module.networking.nat_eip_allocation_id
}

// ────────────────────────────────────
// 🖥️ Servidor Web
// ────────────────────────────────────
output "web_server_public_ip" {
  description = "IP publica del servidor web"
  value       = module.web_server.public_ip
}

output "web_server_instance_id" {
  description = "ID de la instancia del servidor web"
  value       = module.web_server.instance_id
}

// ────────────────────────────────────
// 🏢 Dominio (AD DS)
// ────────────────────────────────────
output "domain_controller_public_ip" {
  description = "IP publica del controlador de dominio"
  value       = module.domain_controller.public_ip
}

output "domain_controller_instance_id" {
  description = "ID de la instancia del controlador de dominio"
  value       = module.domain_controller.instance_id
}

output "domain_controller_private_ip" {
  description = "IP privada del controlador de dominio"
  value       = module.domain_controller.private_ip
}

// ────────────────────────────────────
// 🛡️ IDS / IPS (Suricata)
// ────────────────────────────────────
output "ids_public_ip" {
  description = "IP publica del servidor IDS"
  value       = module.ids.ids_public_ip
}

output "ids_instance_id" {
  description = "ID de la instancia del servidor IDS"
  value       = module.ids.ids_instance_id
}

// ────────────────────────────────────
// 🗂️ Sitio estatico en S3 + CDN + WAF
// ────────────────────────────────────
output "static_site_url" {
  description = "Endpoint HTTP del sitio S3"
  value       = module.static_site.website_endpoint
}


output "logs_bucket_name" {
  description = "Bucket de logs de acceso al sitio"
  value       = module.static_site.logs_bucket_name
}

// ────────────────────────────────────
// 🔣 Sufijo Aleatorio
// ────────────────────────────────────
output "random_suffix" {
  description = "Sufijo aleatorio usado en nombres unicos"
  value       = random_id.suffix.hex
}

// ────────────────────────────────────
// 🔒 VNS3 Firewall / VPN
// ────────────────────────────────────
output "vns3_public_ip" {
  description = "IP pública del firewall VNS3"
  value       = module.vns3_firewall.vns3_public_ip
}

output "vns3_private_ip" {
  description = "IP privada del firewall VNS3"
  value       = module.vns3_firewall.vns3_private_ip
}

output "vns3_ui_url" {
  description = "URL de acceso a la consola web de VNS3"
  value       = module.vns3_firewall.vns3_ui_url
}

output "vns3_instance_id" {
  description = "ID de la instancia del firewall VNS3"
  value       = module.vns3_firewall.vns3_instance_id
}
