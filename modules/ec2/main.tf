# 🚀 Recurso que define una instancia EC2 que actuará como servidor web
resource "aws_instance" "web" {
  ami                         = var.ami_id                           # AMI especificada para el sistema operativo (Amazon Linux 2 u otro)
  instance_type               = "t2.micro"                           # Tipo de instancia (nivel gratuito)
  subnet_id                   = var.subnet_id                        # Subred pública donde se desplegará
  vpc_security_group_ids      = [aws_security_group.web_sg.id]       # Asociar grupo de seguridad definido abajo
  key_name                    = var.key_name                         # Clave SSH para acceso remoto
  user_data                   = data.template_file.user_data.rendered # Script de configuración inicial

  tags = {
    Name = "web-server"                                            # Etiqueta identificadora en AWS
  }
}

# 🔒 Recurso que define el grupo de seguridad para la instancia EC2
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Permite acceso HTTP (80), Node.js (3000) y SSH (22)"
  vpc_id      = var.vpc_id

  # Reglas de entrada (ingress)
  ingress {
    description = "Permitir tráfico HTTP (puerto 80)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Acceso desde cualquier IP
  }

  ingress {
    description = "Permitir tráfico al backend (Node.js) en puerto 3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Permitir acceso SSH (puerto 22) solo desde IP del administrador"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["190.14.138.179/32"] # IP publica del administrador
  }

  # Reglas de salida (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"               # Todos los protocolos
    cidr_blocks = ["0.0.0.0/0"]      # Permitir todo hacia afuera
  }

  tags = {
    Name = "web-sg"  # Nombre del grupo para identificar en consola AWS
  }
}

# 📦 Recurso que genera el script user_data con archivos embebidos codificados en base64
data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")  # Script base

  # Variables que serán reemplazadas en el template
  vars = {
    index_html = base64encode(file("${path.module}/files/index.html"))     # Página principal
    home_html  = base64encode(file("${path.module}/files/home.html"))      # Página secundaria
    style_css  = base64encode(file("${path.module}/files/css/style.css"))  # Estilos del sitio
    login_js   = base64encode(file("${path.module}/files/js/login.js"))    # Lógica frontend
    login_api  = base64encode(file("${path.module}/files/login-api.js"))   # API backend (Node.js)
  }
}
