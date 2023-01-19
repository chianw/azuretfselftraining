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

resource "azurerm_resource_group" "example" {
  name     = data.azurecaf_name.rg_name.result
  location = var.location
}

module "virtual_network" {
  source                   = "./modules/virtual_network"
  vnet_resource_group_name = azurerm_resource_group.example.name
  vnet_name                = data.azurecaf_name.vnet_name.result
}

module "subnet" {
  source                      = "./modules/subnet"
  subnet_resource_group_name  = azurerm_resource_group.example.name
  subnet_virtual_network_name = module.virtual_network.name
}

module "network_interface" {
  source                                = "./modules/network_interface"
  network_interface_resource_group_name = azurerm_resource_group.example.name
  network_interface_subnet_id           = module.subnet.subnet_out.id
}

module "virtual_machine" {
	source = "./modules/virtual_machine"
	vm_resource_group = azurerm_resource_group.example.name
	vm_network_interface_ids = tolist([module.network_interface.network_interface_out.id])
}


# resource "azurerm_key_vault" "example" {
#   name                = "example-kv"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   sku                 = "standard"
# }

# resource "azurerm_key_vault_key" "example" {
#   name         = "example-key"
#   key_vault_id = azurerm_key_vault.example.id
#   key_type     = "RSA"
#   key_size     = 2048
# }



# resource "azurerm_network_interface" "example" {
#   name                = "example-nic"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   network_security_group_id = azurerm_network_security_group.example.id

#   ip_configuration {
#     name                          = "example"
#     subnet_id                     = azurerm_subnet.example.id
#     private_ip_address_allocation = "dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "example" {
#   name                            = "example-vm"
#   location                        = azurerm_resource_group.example.location
#   resource_group_name             = azurerm_resource_group.example.name
#   network_interface_ids           = [azurerm_network_interface.example.id]
#   size                            = "Standard_DS1_v2"
#   admin_username                  = "azureuser"
#   admin_password                  = "mypassword"
#   disable_password_authentication = false

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "20.04-LTS"
#     version   = "latest"
#   }

#   storage_os_disk {
#     name              = "example-os-disk"
#     vhd_uri           = "${azurerm_storage_account.example.primary_blob_endpoint}${azurerm_storage_container.example.name}/example-os-disk
#   }
#   }