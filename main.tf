module "vpc" {
  source             = "./modules/vpc"
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "secrets" {
  source       = "./modules/secrets"
  project_name = var.project_name
}

module "rds" {
  source             = "./modules/rds"
  project_name       = var.project_name
  db_subnet_ids      = module.vpc.private_subnet_ids
  db_security_group  = module.security_groups.rds_sg_id
  db_password        = module.secrets.db_password
  instance_class     = var.db_instance_class
  db_name            = var.db_name
}

module "efs" {
  source         = "./modules/efs"
  project_name   = var.project_name
  efs_subnet_ids = module.vpc.public_subnet_ids
  efs_sg_id      = module.security_groups.efs_sg_id
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
}

module "compute" {
  source              = "./modules/compute"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  web_sg_id           = module.security_groups.web_sg_id
  alb_sg_id           = module.security_groups.alb_sg_id
  acm_certificate_arn = module.acm.certificate_arn
  instance_type       = var.instance_type
  min_size            = 2
  max_size            = 4
  desired_capacity    = 2
  efs_id              = module.efs.efs_id
  db_endpoint         = module.rds.db_endpoint
}

module "cloudflare" {
  source                 = "./modules/cloudflare"
  cloudflare_zone_id     = var.cloudflare_zone_id
  domain_name            = var.domain_name
  alb_dns_name           = module.compute.alb_dns_name
  acm_validation_records = module.acm.validation_records
}