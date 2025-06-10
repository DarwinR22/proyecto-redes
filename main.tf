// ==========================================
// main.tf – Infraestructura raíz para ‘redesYa’
// ==========================================

# 🔀 Identificador aleatorio (sufijo único para nombres únicos, p.ej. S3 bucket)
resource "random_id" "suffix" {
  byte_length = 4
}

# =======================
# 🌐 Módulo VPC principal
# =======================
module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}

# ============================================
# 🌐 Módulo Networking (subnets, IGW, NAT GW)
# ============================================
module "networking" {
  source              = "./modules/networking"
  vpc_id              = module.vpc.vpc_id
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  environment         = var.environment
  admin_ip            = var.admin_ip
  firewall_ip = var.firewall_ip

}

# ============================================
# 🖥️ Módulo Web Server EC2 (Apache + Node + LDAP)
# ============================================
module "web_server" {
  source      = "./modules/ec2"
  ami_id      = var.web_ami_id
  subnet_id   = module.networking.public_subnet_id
  vpc_id      = module.vpc.vpc_id
  key_name    = var.key_name
  environment = var.environment
  project     = var.project
  cost_center = var.cost_center
  owner       = var.owner

  extra_tags = merge(
    var.extra_tags,
    {
      Name    = "web-server"
      Project = "redesYa"
    }
  )
}

# =======================================
# 🌐 Módulo Sitio Estático en S3 (Landing)
# =======================================
module "static_site" {
  source      = "./modules/s3_static_site"
  bucket_name = "redes-static-site-${random_id.suffix.hex}"
  environment = var.environment
  region      = var.region

  extra_tags = merge(
    var.extra_tags,
    {
      Name    = "static-site"
      Project = "redesYa"
    }
  )
}

# ==================================================
# 🏢 Módulo Domain Controller (Windows Server + AD DS)
# ==================================================
module "domain_controller" {
  source        = "./modules/windows_domain_server"
  ami_id        = var.windows_ami_id
  instance_type = var.windows_instance_type
  #subnet_id     = module.networking.public_subnet_id
  subnet_id     = module.networking.private_subnet_id
  vpc_id        = module.vpc.vpc_id
  key_name      = var.key_name

  domain_name         = var.domain_name
  environment         = var.environment
  admin_ip            = var.admin_ip
  vpc_cidr            = var.vpc_cidr
  safe_mode_password  = var.safe_mode_password
  private_ip          = var.domain_controller_private_ip

  extra_tags = merge(
    var.extra_tags,
    {
      Name    = "domain-controller"
      Project = "redesYa"
    }
  )
}

# ====================================
# 🛡️ Módulo IDS/IPS (Suricata + CloudWatch)
# ====================================
module "ids" {
  source        = "./modules/ids_ubuntu"
  ami_id        = var.ubuntu_ami_id
  instance_type = var.ids_instance_type
  subnet_id     = module.networking.public_subnet_id
  #subnet_id     = module.networking.private_subnet_id
  vpc_id        = module.vpc.vpc_id
  key_name      = var.key_name

  admin_ip     = var.admin_ip
  firewall_ip  = var.vpn_server_ip
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  cw_log_group = var.cw_log_group

  extra_tags = merge(
    var.extra_tags,
    {
      Name    = "ids-server"
      Project = "redesYa"
    }
  )
}

# ======================================================
# 🔥 Módulo Firewall – pfSense o VNS3 (comentado por ahora)
# ======================================================
# module "pfsense" {
#   source              = "./modules/pfsense"
#   project_tag         = "redesYa"
#   default_tags        = var.tags
#   vpc_id              = module.vpc.vpc_id
#   public_subnet_id    = module.networking.public_subnet_id
#   private_subnet_id   = module.networking.private_subnet_id
#   ami_id              = var.pfsense_ami_id
#   instance_type       = var.pfsense_instance_type
#   key_name            = var.key_name
#   allowed_admin_cidr  = var.pfsense_allowed_admin_cidr
# }

# =============================================
# 🔒 VPN Server (OpenVPN o VNS3) – Opcional
# =============================================
module "vns3_firewall" {
  source            = "./modules/vns3_firewall"
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.networking.public_subnet_id
  key_name          = var.key_name
  instance_type     = var.firewall_instance_type
  openvpn_ami_id    = var.openvpn_ami_id

  admin_ip          = var.admin_ip
  vpn_client_cidr   = "10.0.3.0/24"
  vpn_server_ip     = "10.0.3.1"
  vpn_client_ip     = "10.0.3.2"

  environment       = var.environment
  project           = var.project
  cost_center       = var.cost_center
  owner             = var.owner
  extra_tags        = var.extra_tags
}

