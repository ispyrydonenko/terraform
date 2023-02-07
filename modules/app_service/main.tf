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
  name                      = var.webapp_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  service_plan_id           = azurerm_service_plan.appserviceplan.id
  https_only                = var.https_only_flag
  virtual_network_subnet_id = var.subnet_id

  identity {
    type = "SystemAssigned"
  }
  connection_string {
    name = "SalesDb"
    # name = "ConnectionStrings__SalesDb"
    type = "SQLAzure"
    # value = local.connection_string
    value = var.connection_string_kv
  }

  app_settings = {
    DOCKER_ENABLE_CI           = var.DOCKER_ENABLE_CI
    DOCKER_REGISTRY_SERVER_URL = "https://registry.hub.docker.com"
    # ASPNETCORE_ENVIRONMENT     = "Development"
    # DOCKER_REGISTRY_SERVER_USERNAME = var.DOCKER_REGISTRY_SERVER_USERNAME
    # DOCKER_REGISTRY_SERVER_PASSWORD = var.DOCKER_REGISTRY_SERVER_PASSWORD
  }
  site_config {
    vnet_route_all_enabled = true
    minimum_tls_version    = "1.2"
    application_stack {
      docker_image     = var.docker_image
      docker_image_tag = var.docker_image_tag
    }
  }

  logs {
    application_logs {
      file_system_level = "Verbose"
    }
    detailed_error_messages = true
    failed_request_tracing  = true
    http_logs {
      file_system {
        retention_in_days = 5
        retention_in_mb   = 100
      }
    }
  }

}

# #  Deploy code from a public GitHub repo
# resource "azurerm_app_service_source_control" "sourcecontrol" {
#   app_id                 = azurerm_linux_web_app.webapp.id
#   repo_url               = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
#   branch                 = "master"
#   use_manual_integration = true
#   use_mercurial          = false
# }
