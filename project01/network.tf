resource "azurerm_virtual_network" "vnet" {
  name                = module.naming.virtual_network.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_addr_space
  dns_servers         = var.dns_servers

  # subnet {
  #   name           = var.app_svc_subnet.name
  #   address_prefix = var.app_svc_subnet.address_prefix
  # }

  # subnet {
  #   name           = var.db_subnet.name
  #   address_prefix = var.db_subnet.address_prefix
  #   # security_group = azurerm_network_security_group.vnet.id
  # }

  # dynamic "subnet" {
  #   for_each = var.subnets
  #   content {
  #     name           = subnet.value.name
  #     address_prefix = subnet.value.address_prefix
  #   }
  # }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets[count.index].address_prefix]

  dynamic "delegation" {
    for_each = var.subnets[count.index].delegation_name == null ? [] : [1]
    content {
      name = "delegation"
      service_delegation {
        name    = var.subnets[count.index].delegation_name
        actions = var.subnets[count.index].delegation_actions
      }
    }
  }


  #  delegation {
  #   name = var.subnets[count.index].delegation_name != null ? null : "delegation"

  #   service_delegation {
  #     name    = var.subnets[count.index].delegation_name
  #     actions = var.subnets[count.index].delegation_actions
  #   }
  # }

}

# resource "azurerm_subnet" "subnets" {
#   for_each = var.subnets
#   name                 = each.value["name"]
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = each.value.address_prefix

#   delegation {
#     name = "delegation"

#     service_delegation {
#       name    = each.value["delegation_name"]
#       actions = each.value["delegation_actions"]
#     }
#   }
# }

# resource "azurerm_subnet" "subnet_appsvc" {
#   name                 = "subnetappsvc"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.1.0/24"]

#   delegation {
#     name = "delegation"

#     service_delegation {
#       name    = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "subnet_db" {
#   name                 = "subnetdb"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

