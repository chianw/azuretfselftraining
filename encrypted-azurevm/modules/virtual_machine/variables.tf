
variable "vm_name" {
  type    = string
  default = "winvm"
}

variable "vm_location" {
  type    = string
  default = "EastUS"
}

variable "vm_resource_group" {
  type    = string
  default = "tftest-resources"
}

variable "vm_network_interface_ids" {
  type    = list(any)
  default = ["interface_ids"]
}

variable "vm_size" {
  type    = string
  default = "Standard_B2ms"
}

