provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "myresourcegroup" {
  name = "a-b-rg-amclu-y-z"
}

output "myresourcegroup" {
  value = data.azurerm_resource_group.myresourcegroup
}

