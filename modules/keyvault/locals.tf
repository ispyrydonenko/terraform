# locals {
#   access_policy = {
#     "terraform" = {
#       "entity_id"           = "${data.azurerm_client_config.current.object_id}"
#       "key_permissions"     = []
#       "secret_permissions"  = ["Get", "List", "Purge", "Recover", "Restore", "Set"]
#       "storage_permissions" = []
#     },
#     "webapp1" = {
#       "entity_id"           = "${var.webapp_identity_id["app1"].identity_id}"
#       "key_permissions"     = []
#       "secret_permissions"  = ["Get"]
#       "storage_permissions" = []
#     },
#     "webapp2" = {
#       "entity_id"           = "${var.webapp_identity_id["app2"].identity_id}"
#       "key_permissions"     = []
#       "secret_permissions"  = ["Get"]
#       "storage_permissions" = []
#     }
#   }

# }
