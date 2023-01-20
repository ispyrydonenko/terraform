resource "azurerm_mssql_server" "sqlsrv" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_login
  administrator_login_password = var.sql_password
}

resource "azurerm_mssql_database" "db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.sqlsrv.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  # license_type   = "LicenseIncluded"
  max_size_gb = 1
  # read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  # tags = {
  #   foo = "bar"
  # }
}
