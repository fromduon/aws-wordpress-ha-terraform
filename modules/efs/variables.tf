variable "project_name" {
  type = string
}

variable "efs_subnet_ids" {
  type = list(string)
}

variable "efs_sg_id" {
  type = string
}