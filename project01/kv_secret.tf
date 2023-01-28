resource "azurerm_key_vault_secret" "secret" {
  name         = "DB-connection-string"
  value        = local.connection_string
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [azurerm_key_vault_access_policy.terraform_policy]
}