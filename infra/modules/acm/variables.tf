variable "domain_name" {
  description = "Full domain name for the certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging"
  type        = string
}