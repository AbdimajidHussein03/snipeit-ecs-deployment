data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

locals {
  app_domain = "${var.subdomain}.${var.domain_name}"
}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  force_delete = var.ecr_force_delete
}

module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  public_subnet_ids     = module.vpc.public_subnet_ids
  rds_security_group_id = module.security.rds_security_group_id

  db_password = var.db_password
}

module "alb" {
  source = "./modules/alb"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  certificate_arn       = module.acm.certificate_arn
}

module "ecs" {
  source = "./modules/ecs"

  project_name       = var.project_name
  ecr_repository_url = module.ecr.repository_url

  db_host     = module.rds.db_endpoint
  db_port     = module.rds.db_port
  db_name     = module.rds.db_name
  db_username = module.rds.db_username
  db_password = var.db_password

  app_url = "https://${local.app_domain}"
  app_key = var.app_key

  public_subnet_ids     = module.vpc.public_subnet_ids
  ecs_security_group_id = module.security.ecs_security_group_id
  target_group_arn      = module.alb.target_group_arn

  depends_on = [module.alb]
}

module "acm" {
  source = "./modules/acm"

  project_name    = var.project_name
  domain_name     = local.app_domain
  route53_zone_id = data.aws_route53_zone.main.zone_id
}

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = local.app_domain
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}
