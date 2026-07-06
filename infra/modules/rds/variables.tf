variable "project_name" {
  description = "Project name used for naming RDS resources"
  type        = string
}

variable "rds_security_group_id" {
  description = "Security group ID for the RDS database"
  type        = string
}

variable "db_name" {
  description = "Database name for Snipe-IT"
  type        = string
  default     = "snipeit"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "snipeitadmin"
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the RDS subnet group"
  type        = list(string)
}