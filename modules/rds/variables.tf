variable "project_name" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "db_security_group" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "instance_class" {
  type = string
}