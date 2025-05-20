# Fase 3.2 - Elastic IP
module "eip" {
  source = "./modules/eip"
  instance_id = module.web_server.instance_id
}

# Fase 3.3 - Firewall pfSense (opcional: si se implementará un EC2 custom con AMI pfSense)
# module "firewall" {
#   source = "./modules/firewall"
#   ...
# }

# Fase 3.4 - Active Directory (Domain Controller)
# module "ad" {
#   source = "./modules/ad"
#   ...
# }

# Fase 3.5 - NAT Gateway (para acceso a internet de subred privada)
# module "nat" {
#   source = "./modules/nat"
#   public_subnet_id = module.networking.public_subnet_id
#   vpc_id = module.vpc.vpc_id
# }

# Fase 3.6 - Load Balancer + HTTPS
# module "alb" {
#   source = "./modules/alb"
#   vpc_id = module.vpc.vpc_id
#   public_subnets = [module.networking.public_subnet_id]
# }

# Fase 3.7 - CloudWatch Monitoring
# module "monitoring" {
#   source = "./modules/monitoring"
#   instance_id = module.web_server.instance_id
# }
