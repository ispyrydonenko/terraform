resource "azurerm_key_vault_access_policy" "policy" {
  for_each     = local.access_policy
  key_vault_id = module.keyvault.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value.entity_id
  key_permissions = each.value.key_permissions
  secret_permissions = each.value.secret_permissions
  storage_permissions = each.value.storage_permissions

  # depends_on = [
  #   module.keyvault
  # ]
}