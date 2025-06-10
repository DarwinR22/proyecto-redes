#########################################
# Security Group para IDS/IPS (Suricata)
#########################################
resource "aws_security_group" "ids_sg" {
  name        = "ids-sg"
  description = "SSH solo desde admin y desde Firewall/VNS3"
  vpc_id      = var.vpc_id

  # SSH desde IP de administrador
  ingress {
    description = "SSH admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  # SSH desde appliance VNS3 (firewall/VPN)
  ingress {
    description = "SSH desde Firewall/VNS3"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.firewall_ip]
  }

  # Salida libre
  egress {
    description = "Permitir todo el trafico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.extra_tags,
    {
      Name       = "ids-sg"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}

#########################################
# Instancia EC2 para IDS/IPS (Suricata)
#########################################
resource "aws_instance" "ids" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ids_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user_data.sh")

  tags = merge(
    var.extra_tags,
    {
      Name       = "ids-server"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}


