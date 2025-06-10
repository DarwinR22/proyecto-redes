
# 🌍 Región AWS
region      = "us-east-1"
environment = "dev"

# 🔐 Par de llaves SSH para acceso a instancias EC2
key_name = "redes-key"

# 🧱 Red – CIDRs y zona de disponibilidad
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
availability_zone   = "us-east-1a"

# 🔐 Dirección IP del administrador para acceso restringido
admin_ip = "190.14.138.134/32"
#ip de jonas 190.14.138.134 mia 190.14.138.189

# 🧾 AMIs específicas para cada tipo de servidor
web_ami_id      = "ami-034ef5aff9ceafb77"    # Amazon Linux 2 para Apache Web Server
firewall_ami_id = "ami-0fb6fd20f553438e3"    # VNS3 Firewall/VPN
windows_ami_id  = "ami-08e34c19a3a69e444"    # Windows Server 2022 + AD
ubuntu_ami_id   = "ami-09579a0c7ceca4162"    # Ubuntu 22.04 para Suricata IDS
openvpn_ami_id  = "ami-0fb6fd20f553438e3"    # Ubuntu 22.04 para OpenVPN

# 🧱 IP privada fija del Domain Controller
domain_controller_private_ip = "10.0.2.145"

# 🧱 IP privada del servidor VPN (si usas VNS3/OpenVPN)
vpn_server_ip = "10.0.3.1/32"
vpn_client_cidr = "10.0.3.0/24"

# 🧱 IP de cliente VPN
vpn_client_ip = "10.0.3.2/32"

# 🔐 Contraseña de Modo Seguro para AD DS
safe_mode_password = "Redes2023!"  # ¡NO compartas esto públicamente!

# 📊 CloudWatch Log Group para IDS
cw_log_group = "/aws/suricata/ids"

# ⚙️ Tipos de instancias EC2
firewall_instance_type = "t2.micro"   # Para VNS3/OpenVPN
ids_instance_type      = "t2.micro"   # Para Suricata IDS
windows_instance_type  = "t2.medium"  # Para AD Domain Controller

# 🏷️ Etiquetas globales del proyecto
project      = "redesYa"
cost_center  = "SECNET"
owner        = "Darwin Lopez"

# 🏷️ Etiquetas adicionales (puedes ampliar aquí si quieres más)
extra_tags = {
  Owner       = "Darwin Lopez"
  Environment = "dev"
  Departamento = "Infraestructura"
  Proyecto     = "redesYa"
}

firewall_ip = "10.0.3.1/32"

#darwinr82
#Redes2024!
#Redes2025!
#RDP XNZMVHpo3JF!?;Gqg5JQlJS4&Rg9jhKN