output "alb_dns_name" {
  value = module.compute.alb_dns_name
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "secrets_manager_secret_name" {
  value = module.secrets.secret_name
}

output "certificate_status" {
  value = module.acm.certificate_status
}