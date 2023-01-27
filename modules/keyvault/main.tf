data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
    ]

    storage_permissions = [
      "Get",
    ]
  }
  
}

# resource "azurerm_key_vault_access_policy" "terraform_policy" {
#   key_vault_id = azurerm_key_vault.kv.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = data.azurerm_client_config.current.object_id

#   secret_permissions = [
#     "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
#   ]
# }

# resource "azurerm_key_vault_access_policy" "webapp_policy" {
#   for_each     = var.webapp_identity_id
#   key_vault_id = azurerm_key_vault.kv.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = each.value.identity_id
#   secret_permissions = ["Get"]
# }

#acc pol from map var
# resource "azurerm_key_vault_access_policy" "policy" {
#   for_each     = local.access_policy
#   key_vault_id = azurerm_key_vault.kv.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = each.value.entity_id
#   key_permissions = each.value.key_permissions
#   secret_permissions = each.value.secret_permissions
#   storage_permissions = each.value.storage_permissions
# }

# resource "azurerm_key_vault_secret" "secret" {
#   name         = var.secret_name
#   value        = var.secret_value
#   key_vault_id = azurerm_key_vault.kv.id

#   depends_on = [azurerm_key_vault_access_policy.policy]
# }
