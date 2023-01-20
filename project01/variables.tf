variable "location" {
  type    = string
  default = "West Europe"
}

variable "resource_group_name" {
  type    = string
  default = "rg-ispyrydonenko-test"
}

variable "vnet_name" {
  type    = string
  default = "myvnet"
}

variable "vnet_addr_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "dns_servers" {
  type    = list(string)
  default = ["10.0.0.4", "10.0.0.5"]
}

variable "subnets" {
  description = "list of values to assign to subnets"
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    { name = "subnetappsvc", address_prefix = "10.0.1.0/24" },
    { name = "subnetdb", address_prefix = "10.0.2.0/24" },
  ]
}

variable "environment" {
  type    = string
  default = "test"
}

variable "sql_admin_login" {
  type    = string
  default = "sqladm"
}
