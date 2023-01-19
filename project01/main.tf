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
  source = "../modules/app_service"
  sql_server_name = local.sql_server_name
  sql_db_name = local.sql_db_name
  sql_login =local.sql_login
  sql_password = local.sql_password
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  webapp_count = 2
}