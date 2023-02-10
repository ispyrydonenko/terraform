resource "azurerm_mssql_server" "sqlsrv_primary" {
  name                         = local.sql_server_name_primary
  resource_group_name          = var.resource_group_name
  location                     = var.location_primary
  version                      = "12.0"
  administrator_login          = var.sql_login
  administrator_login_password = var.sql_password
  tags = {
    server_role = "Primary"
  }
}

resource "azurerm_mssql_server" "sqlsrv_secondary" {
  count                        = var.is_grs ? 1 : 0
  name                         = local.sql_server_name_secondary
  resource_group_name          = var.resource_group_name
  location                     = var.location_secondary
  version                      = "12.0"
  administrator_login          = var.sql_login
  administrator_login_password = var.sql_password
  tags = {
    server_role = "Secondary"
  }
}

resource "azurerm_mssql_database" "db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.sqlsrv_primary.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  # license_type   = "LicenseIncluded"
  max_size_gb = 1
  # read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  tags = {
    DB_role = "Primary"
  }
}

resource "azurerm_mssql_failover_group" "sql_database_failover" {
  count     = var.is_grs ? 1 : 0
  name      = "sql-database-failover"
  server_id = azurerm_mssql_server.sqlsrv_primary.id
  databases = [azurerm_mssql_database.db.id]
  partner_server {
    id = azurerm_mssql_server.sqlsrv_secondary[0].id
  }
  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }
  # depends_on = [azurerm_mssql_database.db]
}

output "sqlsrv_primary_id" {
  value = azurerm_mssql_server.sqlsrv_primary.id
}

output "sqlsrv_primary_name" {
  value = azurerm_mssql_server.sqlsrv_primary.name
}