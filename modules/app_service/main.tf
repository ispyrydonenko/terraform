module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["test"]
}

resource "random_integer" "randint" {
  min = 10000
  max = 99999
}

resource "random_password" "randpass" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

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
  count               = var.webapp_count
  name                = "${local.app_service_name}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  https_only          = true

  connection_string {
    name  = "conn-string-acctest-db-d"
    type  = "SQLAzure"
    value = local.connection_string
  }
  site_config {
    minimum_tls_version = "1.2"
  }
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  count                  = var.webapp_count
  app_id                 = azurerm_linux_web_app.webapp[count.index].id
  repo_url               = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  branch                 = "master"
  use_manual_integration = true
  use_mercurial          = false
}
