resource "azurerm_network_interface" "network_interface" {
  name                = var.network_interface_name
  location            = var.network_interface_location
  resource_group_name = var.network_interface_resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    private_ip_address_allocation = var.private_ip_address_allocation
    subnet_id                     = var.network_interface_subnet_id
  }
}

output "network_interface_out" {
  value = azurerm_network_interface.network_interface
}