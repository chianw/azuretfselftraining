
variable "network_interface_name" {
  type    = string
  default = "vm-nic1"
}

variable "network_interface_location" {
  type    = string
  default = "East US"
}

variable "network_interface_resource_group_name" {
  type    = string
  default = "tftest-resources"
}

variable "ip_configuration_name" {
  type    = string
  default = "vm_ip_config1"
}


variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}

variable "network_interface_subnet_id" {
  type    = string
  default = "subnetid"
}