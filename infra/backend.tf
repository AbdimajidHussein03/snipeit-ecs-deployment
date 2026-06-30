terraform {
  backend "s3" {
    bucket       = "snipe-it-terraform-state-583931059504"
    key          = "ecs-project/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
