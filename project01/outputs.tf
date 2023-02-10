# output "web_app_identity_id" {
#   value = [for k in module.app_service : k.identity_id]
# }

# output "subnets" {
#   value = [for s in module.network.subnets : s.id if s.name == "subnetappsvc"]
# }

# output "sqlsrv_primary_name" {
#   value = module.azsql.sqlsrv_primary_name
# }