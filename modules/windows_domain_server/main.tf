# modules/windows_domain_server/main.tf

#########################################
# 1. user_data con PowerShell para AD DS, DNS y SSM Agent
#########################################
data "template_file" "user_data" {
  template = file("${path.module}/user_data.ps1")
  vars = {
    domain_name           = var.domain_name
    safe_mode_password    = var.safe_mode_password
  }
}

#########################################
# 2. Security Group para Controlador de Dominio
#########################################
resource "aws_security_group" "win_sg" {
  name        = "win-domain-sg"
  description = "RDP desde admin y LDAP/LDAPS/ICMP interna"
  vpc_id      = var.vpc_id

  # RDP desde VNS3 con NAT (IP 10.0.1.210)
  ingress {
    description = "RDP desde VNS3 NAT"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks       = ["10.0.1.210/32"] 
  }

  # RDP solo desde admin
  ingress {
    description = "RDP admin"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  # RDP desde la red VPN WireGuard
  ingress {
    description = "RDP desde VPN"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24"]   # red de tus clientes WireGuard
  }

  # LDAP interno (TCP 389)
  ingress {
    description = "LDAP interno"
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # LDAPS interno (TCP 636)
  ingress {
    description = "LDAPS interno"
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # ICMP (ping) desde VPN
  ingress {
    description = "Ping desde VPN"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.3.0/24"]
  }


  # Egreso libre
  egress {
    description = "Todo trafico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.extra_tags,
    {
      Name       = "win-domain-sg"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
  # RDP desde rango NAT
  ingress {
    description = "RDP desde 100.64.0.0/10"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["100.64.0.0/10"]
  }

  # ICMP desde rango NAT
  ingress {
    description = "Ping desde 100.64.0.0/10"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["100.64.0.0/10"]
  }

}

#########################################
# 3. Instancia Windows Server (AD DS)
#########################################
resource "aws_instance" "windows" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.win_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  private_ip                  = var.private_ip
  user_data                   = data.template_file.user_data.rendered

  tags = merge(
    var.extra_tags,
    {
      Name       = "windows-domain-controller"
      Role       = "AD-Server"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}
