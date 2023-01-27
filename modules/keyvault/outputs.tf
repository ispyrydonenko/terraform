# output "secret_id" {
#   value = azurerm_key_vault_secret.secret.id
# }

output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}