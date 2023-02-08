output "web_app_identity_id" {
  # value    = lookup(module.app_service, "app1")
  # value = module.app_service["app1"].identity_id

  value = [for k in module.app_service : "${k.identity_id}"]
  # sensitive = true
}

# output "connection_string_secret_id" {
#   value = module.keyvault.secret_id
# }

output "subnets" {
  # value = azurerm_virtual_network.vnet.subnet[*].id
  # value = [for s in azurerm_virtual_network.vnet.subnet : s.id if s.name == "subnetappsvc"]
  value = [for s in module.network.subnets : s.id if s.name == "subnetappsvc"]
}

output "sqlsrv_primary_name" {
  value = module.azsql.sqlsrv_primary_name
}