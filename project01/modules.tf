module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = ["test"]
}