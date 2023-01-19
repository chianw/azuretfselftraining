resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.vm_location
  resource_group_name   = var.vm_resource_group
  network_interface_ids = var.vm_network_interface_ids
  vm_size               = var.vm_size

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "linuxvm"
    admin_username = "azureuser"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}