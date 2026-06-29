variable "project_name" {
  description = "Project name used for naming the ECR repository"
  type        = string
}

variable "force_delete" {
  description = "Force delete ECR repository even if it contains images"
  type        = bool
  default     = false
}