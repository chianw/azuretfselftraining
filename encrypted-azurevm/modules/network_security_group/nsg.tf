resource "azurerm_network_security_group" "subnet_nsg" {
  name                = var.subnet_nsg_name
  location            = var.subnet_nsg_location
  resource_group_name = var.subnet_nsg_resource_group_name
}

output "nsg_out" {
  value = azurerm_network_security_group.subnet_nsg
}