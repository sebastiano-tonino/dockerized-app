// Variables definition file
variable "backend_state" {
  type    = string
  default = ""
}

variable "backend" {
  type    = string
  default = ""
}

variable "account" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  type = map(string)
  default = {
    Client     = ""
    Project    = ""
    Stage      = "dev"
    DevOpsTool = "tofu"
  }
}

variable "name_prefix" {
  type    = string
}

variable "db_subnet_group_ids" {
  description = "The VPC subnet IDs for the RDS database."
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "allowed_cidr_blocks" {
  type    = list(string)
  description = "CIDR(s) allowed to access DB (or use app security group)"
}

variable "db_port" {
  type    = number
  default = 3306
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.medium"
}

variable "engine_version" {
  type    = string
}

variable "backup_retention_period" {
  type        = number
  default     = "7"
}

variable "storage_type" {
  type        = string
  default     = ""
  description = "description"
}


variable "storage_type" {
  type    = string
  default = "gp3"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "backup_window" {
  type    = string
  default = "03:00-04:00"
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "deletion_protection" {
  type    = bool
  default = false
}






