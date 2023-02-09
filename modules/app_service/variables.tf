variable "sql_server_name" {
  type = string
}

variable "sql_db_name" {
  type = string
}

variable "sql_login" {
  type = string
}

variable "sql_password" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}
variable "storage_account_name" {
  type = string
}

variable "webapp_name" {
  type = string
}

variable "https_only_flag" {
  type = bool
}

variable "connection_string_kv" {
  type = string
}

# variable "kv_secret_id" {
#   type = string
# }

variable "subnet_id" {
  type = string
}

variable "docker_image" {
  type = string
}

variable "docker_image_tag" {
  type    = string
  default = "latest"
}
variable "dotnet_version" {
  type    = string
  default = "6.0"
}
# variable "DOCKER_REGISTRY_SERVER_USERNAME" {
#   type = string
# }
# variable "DOCKER_REGISTRY_SERVER_PASSWORD" {
#   type = string
# }

variable "DOCKER_ENABLE_CI" {
  type = string
}
# variable "WEBSITE_HTTPLOGGING_ENABLED" {
#   type = bool
# }