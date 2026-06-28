variable "project_name" {
  description = "Project name used for naming ALB resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB and target group will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}