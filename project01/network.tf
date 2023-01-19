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

  dynamic "subnet" {
    for_each = var.subnets
     content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
    }
  }

  tags = {
    environment = var.environment
  }
}