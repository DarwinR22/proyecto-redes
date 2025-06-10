// modules/ec2/main.tf

# 🚀 Instancia EC2 para el servidor web
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  #user_data                   = data.template_file.user_data.rendered

  tags = merge(
    var.extra_tags,
    {
      Name       = "web-server"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}

# 🔒 Security Group del servidor web
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Permite HTTP (80), Node.js (3000) y SSH (22)"
  vpc_id      = var.vpc_id

    ingress {
    description = "Permitir HTTP (80)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Permitir HTTPS (443)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Permitir Node.js (3000)"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Permitir SSH (22) solo desde administrador"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["190.14.138.134/32"]
  }
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
      Name       = "web-sg"
      Project    = var.project
      Env        = var.environment
      CostCenter = var.cost_center
      Owner      = var.owner
    }
  )
}

# 📦 Monta el script user_data con los archivos embebidos
data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    index_html = base64encode(file("${path.module}/files/index.html"))
    home_html  = base64encode(file("${path.module}/files/home.html"))
    style_css  = base64encode(file("${path.module}/files/css/style.css"))
    login_js   = base64encode(file("${path.module}/files/js/login.js"))
    login_api  = base64encode(file("${path.module}/files/login-api.js"))
  }
}
