variable "subnet_name" {
  type    = string
  default = "azureday1-subnet"
}

variable "subnet_virtual_network_name" {
  type    = string
  default = "azureday1-vnet"
}

variable "subnet_resource_group_name" {
  type    = string
  default = "tftest-resources"
}

variable "subnet_address_prefixes" {
  type    = list(any)
  default = ["10.0.0.0/24"]
}