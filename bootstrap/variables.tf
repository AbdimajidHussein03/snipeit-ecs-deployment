variable "aws_region" {
  description = "AWS region for the Terraform backend bucket"
  type        = string
  default     = "eu-west-2"
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
  default     = "snipe-it-terraform-state-583931059504"
}