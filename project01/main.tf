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

# data "azurerm_linux_web_app" "existing" {
#   for_each            = local.webapps
#   resource_group_name = azurerm_resource_group.rg.name
#   name                = each.value.name

# }
module "app_service" {
  for_each = local.webapps

  source = "../modules/app_service"
  depends_on = [module.storage.azsql
  ]
  sql_server_name      = local.sql_server_name
  sql_db_name          = local.sql_db_name
  sql_login            = local.sql_login
  sql_password         = local.sql_password
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  storage_account_name = local.storage_account_name
  webapp_name          = each.value.name
  https_only_flag      = each.value.https_only_flag
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
  # identity_id         = "2af3478a-27da-4837-a387-b22b3fb236a8"
  # identity_id         = module.app_service["app1"].identity_id
  # identity_id         = module.app_service[each.key].identity_id
  identity_id         = local.identities

}