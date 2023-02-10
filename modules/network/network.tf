resource "azurerm_virtual_network" "vnet" {
  name                = module.naming.virtual_network.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_addr_space

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = var.resource_group_name
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

}

resource "azurerm_private_endpoint" "db_endpoint" {
  name                = "sql_endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = [for s in azurerm_subnet.subnets : s.id if s.name == "subnetprivateendpoint"][0]

  private_service_connection {

    name                           = "sqlprivatelink"
    is_manual_connection           = "false"
    private_connection_resource_id = var.sql_server_instance_id
    subresource_names              = ["sqlServer"]
  }
}

resource "azurerm_private_dns_zone" "db_endpoint_dns_private_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

data "azurerm_private_endpoint_connection" "db_endpoint_connection" {
  name                = azurerm_private_endpoint.db_endpoint.name
  resource_group_name = azurerm_private_endpoint.db_endpoint.resource_group_name
}

resource "azurerm_private_dns_a_record" "private_endpoint_a_record" {
  name                = var.sql_server_instance_name
  zone_name           = azurerm_private_dns_zone.db_endpoint_dns_private_zone.name
  resource_group_name = azurerm_private_endpoint.db_endpoint.resource_group_name
  ttl                 = 300
  records             = ["${data.azurerm_private_endpoint_connection.db_endpoint_connection.private_service_connection.0.private_ip_address}"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "zone_to_vnet_link" {
  name                  = "vnet_link"
  resource_group_name   = azurerm_private_endpoint.db_endpoint.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.db_endpoint_dns_private_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

output "private_link_endpoint_ip" {
  value = data.azurerm_private_endpoint_connection.db_endpoint_connection.private_service_connection.0.private_ip_address
}