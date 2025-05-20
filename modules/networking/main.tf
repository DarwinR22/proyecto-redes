# 🌐 Internet Gateway: permite a las instancias en subredes públicas salir a Internet
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  # Este recurso se adjunta a una VPC para habilitar conectividad pública
}

# 🌍 Subred pública: permite el mapeo de IPs públicas al lanzar instancias
resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id                         # VPC a la que pertenece
  cidr_block              = var.public_subnet_cidr             # Rango de direcciones IP
  availability_zone       = var.availability_zone              # Zona de disponibilidad (ej: us-east-1a)
  map_public_ip_on_launch = true                               # Habilita IP pública al lanzar una instancia

  tags = {
    Name = "public-subnet"
  }
}

# 🔐 Subred privada: sin acceso directo a Internet (sin IP pública)
resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "private-subnet"
  }
}

# 🗺️ Tabla de rutas para la subred pública, incluye salida a Internet
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  # Ruta por defecto hacia el Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# 🔗 Asociación entre la tabla de rutas pública y la subred pública
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
