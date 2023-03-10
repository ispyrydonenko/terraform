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

  source               = "../modules/app_service"
  sql_server_name      = local.sql_server_name
  sql_db_name          = local.sql_db_name
  sql_login            = local.sql_login
  sql_password         = local.sql_password
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  storage_account_name = local.storage_account_name
  webapp_name          = each.value.name
  https_only_flag      = each.value.https_only_flag
  connection_string_kv = local.connection_string_kv
  subnet_id            = local.subnet_id_appsvc
  docker_image         = "acc4myjob/dotnet_webapp"
  DOCKER_ENABLE_CI     = true
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
  is_grs               = var.is_grs
}

module "storage" {
  source               = "../modules/storage"
  storage_account_name = local.storage_account_name
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  is_grs               = var.is_grs

}

module "keyvault" {
  source              = "../modules/keyvault"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  key_vault_name      = local.key_vault_name
}

module "network" {
  source                   = "../modules/network"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  subnets                  = var.subnets
  vnet_addr_space          = var.vnet_addr_space
  environment              = var.environment
  sql_server_instance_id   = local.sql_server_instance_id
  sql_server_instance_name = local.sql_server_instance_name
}
