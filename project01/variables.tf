variable "location_primary" {
  type    = string
  default = "West Europe"
}
variable "location_secondary" {
  description = "Used for Geo-redundant replication"
  type        = string
  default     = "North Europe"
}

variable "resource_group_name" {
  type    = string
  default = "rg-ispyrydonenko-test"
}

# variable "vnet_name" {
#   type    = string
#   default = "myvnet"
# }

variable "vnet_addr_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

# variable "dns_servers" {
#   type    = list(string)
#   default = ["10.0.0.4", "10.0.0.5"]
# }

variable "subnets" {
  description = "list of values to assign to subnets"
  type = list(object({
    name               = string
    address_prefix     = string
    delegation_name    = string
    delegation_actions = list(string)
  }))
  default = [
    {
      name            = "subnetappsvc"
      address_prefix  = "10.0.1.0/24"
      delegation_name = "Microsoft.Web/serverFarms"
      # delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action", "Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    },
    {
      name               = "subnetdb"
      address_prefix     = "10.0.2.0/24"
      delegation_name    = null
      delegation_actions = null
    },
    {
      name               = "subnetprivateendpoint"
      address_prefix     = "10.0.3.0/24"
      delegation_name    = null
      delegation_actions = null
    },
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

variable "isGRS" {
  type    = bool
  default = true
  # default     = false
  description = "Flag to enable Geo-redundancy"
}

# variable "DOCKER_REGISTRY_SERVER_USERNAME" {
#   type = string
# }
# variable "DOCKER_REGISTRY_SERVER_PASSWORD" {
#   type = string
# }
