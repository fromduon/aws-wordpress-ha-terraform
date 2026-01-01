resource "aws_secretsmanager_secret" "db_password" {
  name        = "${var.project_name}-db-password-v1"
  description = "RDS password for WordPress"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_password_val" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}