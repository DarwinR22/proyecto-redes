# =======================
# MÓDULO VPN - VNS3 FREE
# =======================

# 📦 Grupo de Seguridad para VNS3 (Web UI puerto 8000 + acceso SSH)
resource "aws_security_group" "vns3_sg" {
  name        = "vns3-sg"
  description = "Permitir acceso a VNS3 (TCP 8000) y SSH"
  vpc_id      = var.vpc_id

  ingress {
    description = "VNS3 Web UI"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["190.14.138.179/32"] # 🔐 Reemplazar con tu IP pública real
  }

  ingress {
    description = "Acceso SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["190.14.138.179/32"]
  }

  ingress {
    description = "WireGuard VPN (UDP 51820)"
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]  # 🔐 Puedes limitar a tu IP o rango corporativo si prefieres
  }

  egress {
    description = "Permitir todo tráfico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vns3-sg"
  }
}

# 💻 Instancia EC2 con la AMI oficial de VNS3 (Marketplace - Free Tier)
resource "aws_instance" "vns3" {
  ami                         = var.openvpn_ami_id                 # AMI proporcionada desde archivo tfvars
  instance_type               = var.instance_type                  # t2.micro o t3.micro (según soporte VNS3 Free)
  subnet_id                   = var.subnet_id                      # Subred pública
  vpc_security_group_ids      = [aws_security_group.vns3_sg.id]    # Grupo de seguridad configurado arriba
  key_name                    = var.key_name                       # Nombre del par de llaves para acceso SSH
  associate_public_ip_address = true                               # Se necesita para acceso externo
  user_data                   = file("${path.module}/user_data.sh")# Script de configuración inicial

  tags = merge(var.tags, {
    Name = "vns3-server"
    Role = "vpn-firewall"
  })
}
