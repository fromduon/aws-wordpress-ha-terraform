output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "secret_name" {
  value = aws_secretsmanager_secret.db_password.name
}