variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name used for naming AWS resources"
  type        = string
  default     = "snipe-it"
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
  default     = "abdimajidcloud.com"
}

variable "subdomain" {
  description = "Subdomain used for the app"
  type        = string
  default     = "tm"
}

variable "db_password" {
  description = "Master password for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name for the application"
  type        = string
  default     = "snipeit"
}

variable "db_username" {
  description = "Database username for the application"
  type        = string
  default     = "snipeitadmin"
}

variable "app_key" {
  description = "Laravel APP_KEY for Snipe-IT"
  type        = string
  sensitive   = true
}

variable "ecr_force_delete" {
  description = "Force delete ECR repository during destroy"
  type        = bool
  default     = false
}