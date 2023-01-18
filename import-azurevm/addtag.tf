resource "azurerm_resource_group" "myresourcegroup" {
  name     = "a-b-rg-amclu-y-z"
  location = "eastus"
  tags = {
	"env" = "prod"
  }
}