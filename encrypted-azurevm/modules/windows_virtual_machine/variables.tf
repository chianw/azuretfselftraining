variable "windows_virtual_machine_name" {
  type    = string
  default = "winvm"	
}

variable "windows_virtual_machine_resource_group_name" {
  type    = string
  default = "tftest-resources"
}

variable "windows_virtual_machine_location" {
  type    = string
  default = "EastUS"
}

variable "windows_virtual_machine_size" {
  type    = string
  default = "Standard_B2ms"
}

variable "windows_virtual_machine_user" {
  type    = string
  default = "azureuser"
}

variable "windows_virtual_machine_password" {
  type    = string
  default = "Password1234!"
}

variable "windows_virtual_machine_interface_id" {
  type    = list(string)
  default = ["interface_ids"]
}

variable "des_id" {
  type    = string
  default = "mydes"
}
