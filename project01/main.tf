# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}


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

module "app_service" {
  for_each             = local.webapps
  
  source               = "../modules/app_service"
  sql_server_name      = local.sql_server_name
  sql_db_name          = local.sql_db_name
  sql_login            = local.sql_login
  sql_password         = local.sql_password
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  storage_account_name = azurerm_storage_account.storage.name
  webapp_name          = each.value.name
  https_only_flag      = each.value.https_only_flag
}

module "azsql" {
  source = "../modules/azsql"
  sql_server_name      = local.sql_server_name
  sql_db_name          = local.sql_db_name
  sql_login            = local.sql_login
  sql_password         = local.sql_password
  storage_account_name = local.storage_account_name
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
}