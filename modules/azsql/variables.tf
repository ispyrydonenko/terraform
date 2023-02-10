variable "sql_server_name" {
  type = string
}

variable "sql_db_name" {
  type = string
}

variable "sql_login" {
  type = string
}

variable "sql_password" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location_primary" {
  type = string
}

variable "location_secondary" {
  type = string
}
variable "storage_account_name" {
  type = string
}

variable "is_grs" {
  type        = bool
  default     = false
  description = "Flag to enable Geo-redundancy"
}