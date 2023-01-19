locals {
  sql_server_name      = "${module.naming.mssql_server.name}-${random_integer.randint.result}"
  sql_db_name          = azurerm_mssql_database.db.name
  sql_login            = azurerm_mssql_server.sqlsrv.administrator_login
  sql_password         = azurerm_mssql_server.sqlsrv.administrator_login_password
  connection_string    = "Server=tcp:${local.sql_server_name}.database.windows.net,1433;Initial Catalog=${local.sql_db_name};Persist Security Info=False;User ID=${local.sql_login};Password=${local.sql_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  storage_account_name = "${module.naming.storage_account.name}${random_integer.randint.result}"
  app_service_name     = "${module.naming.app_service.name}${random_integer.randint.result}"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "resource_group_name" {
  type    = string
  default = "rg-ispyrydonenko-test"
}

variable "vnet_name" {
  type    = string
  default = "myvnet"
}

variable "vnet_addr_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "dns_servers" {
  type    = list(string)
  default = ["10.0.0.4", "10.0.0.5"]
}

# variable "app_svc_subnet" {
#   type = map(any)
#   default = {
#     name           = "subnetappsvc"
#     address_prefix = "10.0.1.0/24"
#   }
# }

# variable "db_subnet" {
#   type = map(any)
#   default = {
#     name           = "subnetdb"
#     address_prefix = "10.0.2.0/24"
#   }
# }

variable "subnets" {
  description = "list of values to assign to subnets"
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    { name = "subnetappsvc", address_prefix = "10.0.1.0/24" },
    { name = "subnetdb", address_prefix = "10.0.2.0/24" },
  ]
}

variable "environment" {
  type    = string
  default = "test"
}

# variable "storage_account_name_prefix" {
#   type    = string
#   default = "mystoragetest"
# }

# variable "sqlserver_name" {
#   type    = string
#   default = "sqlsrv"
# }

variable "sql_admin_login" {
  type    = string
  default = "sqladm"
}

# variable "sql_admin_password" {
#   type        = string
#   description = "Taken from env vars"
#   # sensitive   = true
# }

# variable "db_connection_string" {
#   type = string
# }

variable "webapps" {
  type    = list(string)
  default = ["app-test64029-1", "app-test64029-2"]
}