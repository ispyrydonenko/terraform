output "web_app_identity_id" {
  # value    = lookup(module.app_service, "app1")
  # value = module.app_service["app1"].identity_id
  
  value = [for k in module.app_service : "${k.identity_id}"]
  # sensitive = true
}