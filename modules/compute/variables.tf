variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "web_sg_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "efs_id" {
  type = string
}

variable "db_endpoint" {
  type = string
}