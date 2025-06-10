# modules/vns3_firewall/main.tf

# Template for user_data (WireGuard config)
data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh.tpl")
  vars = {
    vpn_server_ip  = var.vpn_server_ip
    vpn_client_ip  = var.vpn_client_ip
  }
}

# Security Group for VNS3 UI, SSH and WireGuard
resource "aws_security_group" "vns3_sg" {
  name        = "vns3-sg"
  description = "VNS3 Web UI (8000), SSH (22) y WireGuard (51820)"
  vpc_id      = var.vpc_id

  # Web UI: only admin
  ingress {
    description = "VNS3 Web UI"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  # SSH: only admin
  ingress {
    description = "SSH admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  # WireGuard: only VPN clients subnet
  ingress {
    description = "WireGuard VPN"
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = [var.vpn_client_cidr]
  }
  # WireGuard desde casa (producción controlada)
  ingress {
    description = "WireGuard desde casa"
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = [var.admin_ip]  # Tu IP pública fija (ej. 190.14.138.134/32)
  }


  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.extra_tags,
    {
      Name       = "vns3-sg"
      Role       = "vpn-firewall"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}

# VNS3 appliance instance
resource "aws_instance" "vns3" {
  ami                         = var.openvpn_ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.vns3_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = data.template_file.user_data.rendered
  private_ip    = "10.0.1.210"     
  tags = merge(
    var.extra_tags,
    {
      Name       = "vns3-server"
      Role       = "vpn-firewall"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}

