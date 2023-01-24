locals {
  key_vault_name = "${module.naming.key_vault.name}-${random_integer.randint.result}"
  # identities = [module.app_service[*].identity_id]

  #-------------------------------------------------------------------------------------------------------------

  sql_server_name   = "${module.naming.mssql_server.name}-${random_integer.randint.result}"
  sql_db_name       = module.naming.mssql_database.name
  sql_login         = var.sql_admin_login
  sql_password      = random_password.randpass.result
  connection_string = "Server=tcp:${local.sql_server_name}.database.windows.net,1433;Initial Catalog=${local.sql_db_name};Persist Security Info=False;User ID=${local.sql_login};Password=${local.sql_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

  #-------------------------------------------------------------------------------------------------------------

  storage_account_name = "${module.naming.storage_account.name}${random_integer.randint.result}"
  app_service_name     = "${module.naming.app_service.name}${random_integer.randint.result}"

  #-------------------------------------------------------------------------------------------------------------
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

  #-------------------------------------------------------------------------------------------------------------

  sql_servers = {
    primary = {
      name = "${local.sql_server_name}-primary"
    },
    secondary = {
      name = "${local.sql_server_name}-secondary"

    }
  }

}
