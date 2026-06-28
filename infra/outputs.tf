output "app_domain" {
  description = "The full domain name for the app"
  value       = local.app_domain
}

output "route53_zone_id" {
  description = "The existing Route 53 hosted zone ID"
  value       = data.aws_route53_zone.main.zone_id
}

output "vpc_id" {
  description = "Terraform-created VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Terraform-created public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = module.security.alb_security_group_id
}

output "ecs_security_group_id" {
  description = "ECS security group ID"
  value       = module.security.ecs_security_group_id
}

output "rds_security_group_id" {
  description = "RDS security group ID"
  value       = module.security.rds_security_group_id
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
}

output "rds_port" {
  description = "RDS database port"
  value       = module.rds.db_port
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "ecs_task_definition_arn" {
  description = "ECS task definition ARN"
  value       = module.ecs.task_definition_arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "target_group_arn" {
  description = "ARN of the ALB target group"
  value       = module.alb.target_group_arn
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = module.ecs.ecs_service_name
}

output "certificate_arn" {
  description = "ACM certificate ARN"
  value       = module.acm.certificate_arn
}

output "app_url" {
  description = "Final HTTPS application URL"
  value       = "https://${local.app_domain}"
}

output "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions"
  value       = module.iam.github_actions_role_arn
}