variable "project_name" {
  description = "Project name used for naming security groups"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}