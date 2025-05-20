# 🔐 Grupo de Seguridad para el Controlador de Dominio (Windows Server)
resource "aws_security_group" "win_sg" {
  name        = "win-domain-sg"
  description = "Permite RDP y LDAP desde red privada"
  vpc_id      = var.vpc_id

  # Permitir conexión remota vía RDP desde cualquier IP (⚠️ restringir en producción)
  ingress {
    description = "RDP Access"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir tráfico LDAP desde dentro de la VPC
  ingress {
    description = "LDAP desde red privada"
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # Permitir pings ICMP para pruebas de red desde la red interna
  ingress {
    description = "Ping (ICMP)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # Todo el tráfico de salida está permitido
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "win-domain-sg"
  }
}

# 🖥️ Instancia EC2 que actuará como Controlador de Dominio (Active Directory)
resource "aws_instance" "windows" {
  ami                         = var.ami_id                           # AMI de Windows Server (ej. 2019 Base)
  instance_type               = var.instance_type                    # Requiere al menos 2 vCPU para AD
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.win_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  # IP privada fija para referencia por parte del servidor web o IDS
  private_ip = "10.0.1.145"

  tags = merge(var.tags, {
    Name    = "windows-domain-controller"
    Role    = "AD-Server"
    Project = "redes1705"
  })
}
