# Create the Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = module.naming.app_service_plan.name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                = var.webapp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  https_only          = var.https_only_flag

  identity {
    type = "SystemAssigned"
  }
  connection_string {
    name  = "conn_string_${var.sql_db_name}"
    type  = "SQLAzure"
    # value = local.connection_string
    value = var.connection_string_kv
  }
  site_config {
    minimum_tls_version = "1.2"
  }
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                 = azurerm_linux_web_app.webapp.id
  repo_url               = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  branch                 = "master"
  use_manual_integration = true
  use_mercurial          = false
}