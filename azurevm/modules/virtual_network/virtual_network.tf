resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = var.vnet_resource_group_name
  address_space       = var.vnet_address_space
#   dns_servers         = var.vnet_dns_servers
  tags                = var.vnet_tag_name
}

output "name" {
  value = azurerm_virtual_network.vnet.name
}

output "id" {
  value = azurerm_virtual_network.vnet.id
}

output "resource_group_name" {
  value = azurerm_virtual_network.vnet.resource_group_name
}

output "location" {
  value = azurerm_virtual_network.vnet.location
}