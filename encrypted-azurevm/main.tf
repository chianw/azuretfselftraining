data "azurerm_client_config" "current" {}

data "azurecaf_name" "rg_name" {
  resource_type = "azurerm_resource_group"
  prefixes      = ["tf"]
  suffixes      = ["dev"]
  random_length = 5
  clean_input   = true
}

data "azurecaf_name" "vnet_name" {
  resource_type = "azurerm_virtual_network"
  prefixes      = ["tf"]
  suffixes      = ["dev"]
  random_length = 5
  clean_input   = true
}

data "azurecaf_name" "key_vault_name" {
  resource_type = "azurerm_key_vault"
  prefixes      = ["tf"]
  suffixes      = ["dev"]
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

module "network_security_group" {
  source                         = "./modules/network_security_group"
  subnet_nsg_resource_group_name = azurerm_resource_group.example.name
}

module "network_interface" {
  source                                = "./modules/network_interface"
  network_interface_resource_group_name = azurerm_resource_group.example.name
  network_interface_subnet_id           = module.subnet.subnet_out.id
}

# module "virtual_machine" {
#   source                   = "./modules/virtual_machine"
#   vm_resource_group        = azurerm_resource_group.example.name
#   vm_network_interface_ids = tolist([module.network_interface.network_interface_out.id])
# }

module "windows_virtual_machine" {
  source = "./modules/windows_virtual_machine"
  windows_virtual_machine_resource_group_name = azurerm_resource_group.example.name
  windows_virtual_machine_interface_id = tolist([module.network_interface.network_interface_out.id])
  des_id = module.disk_encryption_set.disk_encryption_set_out.id
}


resource "azurerm_subnet_network_security_group_association" "nsg_to_subnet" {
  subnet_id                 = module.subnet.subnet_out.id
  network_security_group_id = module.network_security_group.nsg_out.id
}


module "key_vault" {
  source                        = "./modules/key_vault"
  key_vault_name                = data.azurecaf_name.key_vault_name.result
  key_vault_resource_group_name = azurerm_resource_group.example.name
}


module "disk_encryption_set" {
  source                                  = "./modules/disk_encryption_set"
  disk_encryption_set_resource_group_name = azurerm_resource_group.example.name
  disk_encryption_set_keyvaultkey_id      = module.key_vault.key_vault_key_out.id
}

resource "azurerm_key_vault_access_policy" "kv-access-policy-des" {
  key_vault_id = module.key_vault.key_vault_out.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.disk_encryption_set.disk_encryption_set_out.identity.0.principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey",
    "Create",
    "Delete",
    "Purge",
    "Recover",
    "Update",
    "List",
    "Decrypt",
    "Sign"
  ]
}



