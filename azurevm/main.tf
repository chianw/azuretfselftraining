provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

# provider "azurecaf" {
#   # Configuration options
# }

data "azurecaf_name" "rg_name" {
  resource_type = "azurerm_resource_group"
  prefixes      = ["a", "b"]
  suffixes      = ["y", "z"]
  random_length = 5
  clean_input   = true
}

data "azurecaf_name" "vnet_name" {
  resource_type = "azurerm_virtual_network"
  prefixes      = ["a", "b"]
  suffixes      = ["y", "z"]
  random_length = 5
  clean_input   = true
}

resource "azurerm_resource_group" "main" {
  name     = data.azurecaf_name.rg_name.result
  location = var.location
}

# resource "azurerm_virtual_network" "main" {
#   name                = "${var.prefix}-network"
#   address_space       = ["10.0.0.0/22"]
#   location            = azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name
# }

module "virtual_network" {
  source                   = "./modules/virtual_network"
  vnet_resource_group_name = azurerm_resource_group.main.name
  # vnet_name                = "tftest-vnet"
  vnet_name = data.azurecaf_name.vnet_name.result
  # depends_on = [
  #   azurerm_resource_group.main
  # ]
}

output "virtual_network" {
  value = module.virtual_network
}


resource "azurerm_subnet" "internal" {
  name                = "internal"
  resource_group_name = azurerm_resource_group.main.name
  # virtual_network_name = "azureday1-vnet"
  virtual_network_name = module.virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_B2s"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}