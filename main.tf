module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "networking" {
  source              = "./modules/networking"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}

module "web_server" {
  source     = "./modules/ec2"
  ami_id     = "ami-0f88e80871fd81e91" # Amazon Linux 2 en us-east-1
  subnet_id  = module.networking.public_subnet_id
  vpc_id     = module.vpc.vpc_id
  key_name   = "redes-key"
}

resource "random_id" "suffix" {
  byte_length = 4
}

module "static_site" {
  source      = "./modules/s3_static_site"
  bucket_name = "redes-static-site-${random_id.suffix.hex}"
}
