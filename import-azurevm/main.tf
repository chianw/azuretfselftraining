provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "myresourcegroup" {
  name = "myabcdresourcegroup"
}

output "myresourcegroup" {
  value = data.azurerm_resource_group.myresourcegroup
}

