resource "azurerm_windows_virtual_machine" "winvm" {
  name                = var.windows_virtual_machine_name
  resource_group_name = var.windows_virtual_machine_resource_group_name
  location            = var.windows_virtual_machine_location
  size                = var.windows_virtual_machine_size
  admin_username      = var.windows_virtual_machine_user
  admin_password      = var.windows_virtual_machine_password
  network_interface_ids = var.windows_virtual_machine_interface_id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
	disk_encryption_set_id = var.des_id
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

output "winvm_out" {
  value = azurerm_windows_virtual_machine.winvm
}