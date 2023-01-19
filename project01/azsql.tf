resource "azurerm_storage_account" "storage" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "sqlsrv" {
  name                         = local.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = random_password.randpass.result
  # administrator_login_password = var.sql_admin_password
  # administrator_login          = "4dm1n157r470r"
}

resource "azurerm_mssql_database" "db" {
  name      = module.naming.mssql_database.name
  server_id = azurerm_mssql_server.sqlsrv.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  # license_type   = "LicenseIncluded"
  max_size_gb = 1
  # read_scale     = true
  sku_name       = "S0"
  zone_redundant = false

  # tags = {
  #   foo = "bar"
  # }
}
