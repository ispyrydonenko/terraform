locals {
  sql_server_name      = "${module.naming.mssql_server.name}-${random_integer.randint.result}"
  sql_db_name          = azurerm_mssql_database.db.name
  sql_login            = azurerm_mssql_server.sqlsrv.administrator_login
  sql_password         = azurerm_mssql_server.sqlsrv.administrator_login_password
  connection_string    = "Server=tcp:${local.sql_server_name}.database.windows.net,1433;Initial Catalog=${local.sql_db_name};Persist Security Info=False;User ID=${local.sql_login};Password=${local.sql_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  storage_account_name = "${module.naming.storage_account.name}${random_integer.randint.result}"
  app_service_name     = "${module.naming.app_service.name}${random_integer.randint.result}"

  webapps = {

    app1 = {
      name            = "app-test64029-1",
      https_only_flag = true
    },
    app2 = {
      name            = "app-test64029-2"
      https_only_flag = false
    }
  }

}
