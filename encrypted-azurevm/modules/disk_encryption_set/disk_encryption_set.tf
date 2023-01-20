resource "azurerm_disk_encryption_set" "disk_encryption_set" {
  name                = var.disk_encryption_set_name
  resource_group_name = var.disk_encryption_set_resource_group_name
  location            = var.disk_encryption_set_location
  key_vault_key_id    = var.disk_encryption_set_keyvaultkey_id

  identity {
    type = "SystemAssigned"
  }
}


output "disk_encryption_set_out" {
  value = azurerm_disk_encryption_set.disk_encryption_set
}