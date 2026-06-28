output "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions OIDC"
  value       = aws_iam_role.github_actions.arn
}