variable "project_name" {
  description = "Project name used for naming IAM resources"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository allowed to assume this role"
  type        = string
}