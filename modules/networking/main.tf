#########################################
# 1. Subredes
#########################################
resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = merge(
    { Name = "public-subnet" },
    var.extra_tags
  )
}

resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone
  tags = merge(
    { Name = "private-subnet" },
    var.extra_tags
  )
}

#########################################
# 2. Internet Gateway y ruta pública
#########################################
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags   = merge({ Name = "igw" }, var.extra_tags)
}

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = merge({ Name = "public-rt" }, var.extra_tags)
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

#########################################
# 3. Elastic IP y NAT Gateway
#########################################
resource "aws_eip" "nat" {
  tags = merge({ Name = "nat-eip" }, var.extra_tags)
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags = merge({ Name = "nat-gateway" }, var.extra_tags)
}

#########################################
# 4. Tabla de rutas privada
#########################################
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = merge({ Name = "private-rt" }, var.extra_tags)
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

#########################################
# 5. NACL pública segura
#########################################
resource "aws_network_acl" "public_nacl" {
  vpc_id = var.vpc_id
  tags   = merge({ Name = "public-nacl" }, var.extra_tags)
}

resource "aws_network_acl_rule" "public_allow_wireguard_in" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 115
  egress         = false
  protocol       = "17"            # UDP
  rule_action    = "allow"
  cidr_block     = var.admin_ip    # o "0.0.0.0/0" para pruebas
  from_port      = 51820
  to_port        = 51820
}

resource "aws_network_acl_rule" "public_allow_wireguard_out" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 115
  egress         = true
  protocol       = "17"            # UDP
  rule_action    = "allow"
  cidr_block     = var.admin_ip    # o "0.0.0.0/0" si estás en pruebas
  from_port      = 51820
  to_port        = 51820
}



# Ingress rules (únicamente lo necesario)
resource "aws_network_acl_rule" "public_allow_http" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "6" # TCP
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_allow_ssh" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 105
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "190.14.138.134/32" # tu IP pública
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "public_allow_https" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 110
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_allow_nodejs" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 120
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 3000
  to_port        = 3000
}

# Permitir retorno de conexiones salientes (puertos efímeros 1024-65535)
resource "aws_network_acl_rule" "public_allow_ephemeral_in" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 130
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

# Egress rules
resource "aws_network_acl_rule" "public_allow_all_egress" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"   # all
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "public_nacl_assoc" {
  subnet_id      = aws_subnet.public.id
  network_acl_id = aws_network_acl.public_nacl.id
}

#########################################
# 6. NACL privada (restringida pero funcional)
#########################################
resource "aws_network_acl" "private_nacl" {
  vpc_id = var.vpc_id
  tags   = merge({ Name = "private-nacl" }, var.extra_tags)
}

# Ingress dentro de la VPC (permitir tráfico este-oeste)
resource "aws_network_acl_rule" "private_allow_vpc_ingress" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 110
  egress         = false
  protocol       = "-1"   # all
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
}

resource "aws_network_acl_rule" "private_allow_rdp" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 120
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "190.14.138.134/32"
  from_port      = 3389
  to_port        = 3389
}

# Permitir retorno de conexiones hacia NAT (puertos efímeros)
resource "aws_network_acl_rule" "private_allow_ephemeral_in" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 130
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr  # sólo el interior de la VPC
  from_port      = 1024
  to_port        = 65535
}

# Egress hacia Internet vía NAT
resource "aws_network_acl_rule" "private_allow_all_egress" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "private_nacl_assoc" {
  subnet_id      = aws_subnet.private.id
  network_acl_id = aws_network_acl.private_nacl.id
}

resource "aws_network_acl_rule" "private_allow_rdp_from_vpn" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 140          # que no choque con otro número
  egress         = false
  protocol       = "6"          # TCP
  rule_action    = "allow"
  cidr_block     = "10.0.3.0/24"
  from_port      = 3389
  to_port        = 3389
}

resource "aws_network_acl_rule" "private_allow_icmp_from_vpn" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 141
  egress         = false
  protocol       = "1"            # ICMP
  rule_action    = "allow"
  cidr_block     = "10.0.3.0/24"
  from_port      = 8              # Echo Request
  to_port        = -1
}

# RDP desde rango NAT (100.64.0.0/10)
resource "aws_network_acl_rule" "private_allow_rdp_from_nat_range" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 150
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "100.64.0.0/10"
  from_port      = 3389
  to_port        = 3389
}

# ICMP desde rango NAT (100.64.0.0/10)
resource "aws_network_acl_rule" "private_allow_icmp_from_nat_range" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 151
  egress         = false
  protocol       = "1"
  rule_action    = "allow"
  cidr_block     = "100.64.0.0/10"
  from_port      = 8
  to_port        = -1
}
