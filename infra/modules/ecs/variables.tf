variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URL for the Snipe-IT image"
  type        = string
}

variable "db_host" {
  description = "RDS database endpoint"
  type        = string
}

variable "db_port" {
  description = "RDS database port"
  type        = number
}

variable "db_name" {
  description = "Snipe-IT database name"
  type        = string
}

variable "db_username" {
  description = "Snipe-IT database username"
  type        = string
}

variable "db_password" {
  description = "Snipe-IT database password"
  type        = string
  sensitive   = true
}

variable "app_url" {
  description = "Public application URL"
  type        = string
}

variable "app_key" {
  description = "Laravel APP_KEY for Snipe-IT"
  type        = string
  sensitive   = true
}

variable "public_subnet_ids" {
  description = "Public subnet IDs where ECS tasks will run"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN for the ECS service"
  type        = string
}