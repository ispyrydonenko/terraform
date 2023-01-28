resource "azurerm_key_vault_access_policy" "terraform_policy" {
  key_vault_id = module.keyvault.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
}

resource "azurerm_key_vault_access_policy" "policy" {
  for_each            = local.access_policy
  key_vault_id        = module.keyvault.key_vault_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = each.value.entity_id
  secret_permissions  = each.value.secret_permissions
  key_permissions     = each.value.key_permissions
  storage_permissions = each.value.storage_permissions

  # lifecycle {
  #   ignore_changes = [
  #     secret_permissions
  #   ]
  # }

  # depends_on = [
  #   module.keyvault
  # ]

}
