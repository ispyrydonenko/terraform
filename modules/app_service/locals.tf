locals {
  connection_string_pattern = "@Microsoft.KeyVault(SecretUri=[link])"
  connection_string = replace(local.connection_string_pattern, "[link]", var.kv_secret_id)
  # connection_string = "Server=tcp:${var.sql_server_name}.database.windows.net,1433;Initial Catalog=${var.sql_db_name};Persist Security Info=False;User ID=${var.sql_login};Password=${var.sql_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}