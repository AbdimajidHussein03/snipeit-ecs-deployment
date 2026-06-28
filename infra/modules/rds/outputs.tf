output "db_endpoint" {
  description = "RDS database endpoint used by ECS as DB_HOST"
  value       = aws_db_instance.main.address
}

output "db_port" {
  description = "RDS database port"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Database name used by Snipe-IT"
  value       = aws_db_instance.main.db_name
}

output "db_username" {
  description = "Database username used by Snipe-IT"
  value       = aws_db_instance.main.username
}