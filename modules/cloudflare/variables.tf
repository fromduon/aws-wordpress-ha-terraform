variable "cloudflare_zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "acm_validation_records" {
  type = any
}