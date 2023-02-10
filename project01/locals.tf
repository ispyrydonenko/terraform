locals {

  access_policy = {
    "webapp1" = {
      "entity_id"           = local.webapp_identity_id["app1"].identity_id
      "key_permissions"     = []
      "secret_permissions"  = ["Get"]
      "storage_permissions" = []
    },
    "webapp2" = {
      "entity_id"           = local.webapp_identity_id["app2"].identity_id
      "key_permissions"     = []
      "secret_permissions"  = ["Get"]
      "storage_permissions" = []
    }
  }

  key_vault_name               = "${module.naming.key_vault.name}-${random_integer.randint.result}"
  webapp_identity_id           = module.app_service
  connection_string_kv_pattern = "@Microsoft.KeyVault(SecretUri=[link])"
  connection_string_kv         = replace(local.connection_string_kv_pattern, "[link]", azurerm_key_vault_secret.secret.id)

  #-------------------------------------------------------------------------------------------------------------

  sql_server_name   = "${module.naming.mssql_server.name}-${random_integer.randint.result}"
  sql_db_name       = module.naming.mssql_database.name
  sql_login         = var.sql_admin_login
  sql_password      = random_password.randpass.result
  connection_string = "Server=tcp:${module.azsql.sqlsrv_primary_name}.database.windows.net,1433;Initial Catalog=${local.sql_db_name};Persist Security Info=False;User ID=${local.sql_login};Password=${local.sql_password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

  #-------------------------------------------------------------------------------------------------------------

  storage_account_name = "${module.naming.storage_account.name}${random_integer.randint.result}"

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

  subnet_id_appsvc = [for s in module.network.subnets : s.id if s.name == "subnetappsvc"][0]

  #-------------------------------------------------------------------------------------------------------------

  sql_server_instance_id   = module.azsql.sqlsrv_primary_id
  sql_server_instance_name = module.azsql.sqlsrv_primary_name
}
