# Generate a random integer to create a globally unique name
resource "random_integer" "randint" {
  min = 10000
  max = 99999
}

resource "random_password" "randpass" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

data "azurerm_client_config" "current" {}


module "app_service" {
  for_each = local.webapps

  source = "../modules/app_service"
  # depends_on = [module.azsql, module.keyvault]

  sql_server_name      = local.sql_server_name
  sql_db_name          = local.sql_db_name
  sql_login            = local.sql_login
  sql_password         = local.sql_password
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  storage_account_name = local.storage_account_name
  webapp_name          = each.value.name
  https_only_flag      = each.value.https_only_flag
  kv_secret_id         = azurerm_key_vault_secret.secret.id
  # kv_secret_id         = "TEST!"
  # kv_secret_id         = module.keyvault.secret_id
}

module "azsql" {
  source               = "../modules/azsql"
  sql_server_name      = local.sql_server_name
  sql_db_name          = local.sql_db_name
  sql_login            = local.sql_login
  sql_password         = local.sql_password
  storage_account_name = local.storage_account_name
  resource_group_name  = azurerm_resource_group.rg.name
  location_primary     = azurerm_resource_group.rg.location
  location_secondary   = var.location_secondary
  isGRS                = var.isGRS
}

module "storage" {
  source               = "../modules/storage"
  storage_account_name = local.storage_account_name
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  isGRS                = var.isGRS

}

module "keyvault" {
  # for_each = local.webapps
  source              = "../modules/keyvault"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  key_vault_name      = local.key_vault_name
  # webapp_identity_id  = local.webapp_identity_id
  # secret_name         = "DB-connection-string"
  # secret_value        = local.connection_string
}
