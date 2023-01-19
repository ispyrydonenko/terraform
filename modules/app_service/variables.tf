locals {
  connection_string    = "Server=tcp:${var.sql_server_name}.database.windows.net,1433;Initial Catalog=${var.sql_db_name};Persist Security Info=False;User ID=${var.sql_login};Password=${var.sql_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}

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

variable "location" {
  type = string
}
variable "storage_account_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "webapps" {
  type = list
}