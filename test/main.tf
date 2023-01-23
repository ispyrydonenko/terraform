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


data "azurerm_extended_locations" "example" {
  location = "West Europe"
}

output "loc" {
  description = "Azure extended locations:"
  value       = data.azurerm_extended_locations.example
}