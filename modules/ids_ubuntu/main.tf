# 🛡️ Grupo de Seguridad para IDS/IPS
resource "aws_security_group" "ids_sg" {
  name        = "ids-sg"
  description = "Acceso SSH para IDS/IPS"
  vpc_id      = var.vpc_id

  ingress {
    description = "Permitir conexión SSH desde cualquier IP (puerto 22)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 🔐 Recomendación: restringir a IPs conocidas en producción
  }

  egress {
    description = "Permitir todo el tráfico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"               # Todos los protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ids-sg"
  }
}

# 🧠 Instancia EC2 que actuará como IDS/IPS usando Suricata
resource "aws_instance" "ids" {
  ami                         = var.ami_id                           # AMI basada en Ubuntu
  instance_type               = var.instance_type                    # t2.micro (nivel gratuito)
  subnet_id                   = var.subnet_id                        # Subred privada o pública
  vpc_security_group_ids      = [aws_security_group.ids_sg.id]       # Grupo de seguridad con acceso SSH
  key_name                    = var.key_name                         # Clave SSH
  associate_public_ip_address = true                                 # Se asigna IP pública
  user_data                   = file("${path.module}/user_data.sh")  # Script de instalación de Suricata

  tags = var.tags
}
