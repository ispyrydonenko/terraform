variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_addr_space" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "subnets" {
  type = list(object({
    name               = string
    address_prefix     = string
    delegation_name    = string
    delegation_actions = list(string)
  }))
}

variable "sql_server_instance_id" {
  type = string
}

variable "sql_server_instance_name" {
  type = string
}