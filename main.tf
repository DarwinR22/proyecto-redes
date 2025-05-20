# 🔀 Identificador aleatorio para nombres únicos (usado por ejemplo para nombre de S3)
resource "random_id" "suffix" {
  byte_length = 4
}

# =======================
# 🌐 Módulo de Red - VPC
# =======================
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "networking" {
  source              = "./modules/networking"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}

# ============================
# 🖥️ Servidor Web EC2 (Apache)
# ============================
module "web_server" {
  source     = "./modules/ec2"
  ami_id     = var.web_ami_id
  subnet_id  = module.networking.public_subnet_id
  vpc_id     = module.vpc.vpc_id
  key_name   = var.key_name
}

# =====================
# 🌐 Sitio estático S3
# =====================
module "static_site" {
  source      = "./modules/s3_static_site"
  bucket_name = "redes-static-site-${random_id.suffix.hex}"
}

# ==============================================
# 🏢 Servidor de Dominio (Windows Server + AD DS)
# ==============================================
module "domain_controller" {
  source        = "./modules/windows_domain_server"
  ami_id        = var.windows_ami_id
  instance_type = "t2.medium"
  subnet_id     = module.networking.public_subnet_id
  vpc_id        = module.vpc.vpc_id
  key_name      = var.key_name

  tags = {
    Name    = "domain-controller"
    Project = "seguridad-redes"
    Owner   = "tu_nombre"
  }
}

# ============================
# 🛡️ IDS / IPS - Suricata
# ============================
module "ids" {
  source        = "./modules/ids_ubuntu"
  ami_id        = var.ubuntu_ami_id
  instance_type = "t2.micro"
  subnet_id     = module.networking.public_subnet_id
  vpc_id        = module.vpc.vpc_id
  key_name      = var.key_name

  tags = {
    Name    = "ids-server"
    Project = "seguridad-redes"
    Owner   = "tu_nombre"
  }
}

# ===============================
# 🔒 VPN con VNS3 (Firewall/NAT)
# ===============================
module "vpn" {
  source         = "./modules/vpn_openvpn"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.networking.public_subnet_id
  key_name       = var.key_name
  instance_type  = var.firewall_instance_type
  openvpn_ami_id = var.openvpn_ami_id

  tags = {
    Name    = "vpn-server"
    Project = "seguridad-redes"
    Owner   = "Darwin Lopez"
  }
}
