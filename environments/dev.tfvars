# 🔐 AMIs específicas por sistema operativo
web_ami_id      = "ami-076247d95990dec3e"    # Amazon Linux 2 (Servidor Web Apache)
firewall_ami_id = "ami-0cccf8d9cc60361e8"    # VNS3 Free VPN/Firewall (Marketplace)
windows_ami_id  = "ami-069c83816748ce7d5"    # Windows Server 2019 con AD configurado
ubuntu_ami_id   = "ami-053b0d53c279acc90"    # Ubuntu Server 22.04 (para IDS con Suricata)
openvpn_ami_id  = "ami-01a93fd5fe4058a3d"    # Ubuntu Server 22.04 (OpenVPN Server)

# 🧾 Nombre del par de llaves SSH para acceso a las instancias EC2
key_name = "redes-key"

# ⚙️ Configuración específica para el firewall/VPN
firewall_instance_type = "t2.micro"  # Elegible para Free Tier

# ⚙️ Parámetros generales usados opcionalmente por otros módulos EC2
associate_public_ip_address = true
monitoring                  = false
volume_size                 = 30  # GB del volumen raíz EBS


