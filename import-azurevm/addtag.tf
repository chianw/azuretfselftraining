resource "azurerm_resource_group" "myresourcegroup" {
  name     = "myabcdresourcegroup"
  location = "eastus"
  tags = {
	"env" = "prod"
  }
}