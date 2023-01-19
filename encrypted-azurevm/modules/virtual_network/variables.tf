variable "vnet_resource_group_name" {
  type    = string
  default = "tftest-resources"
}

variable "vnet_location" {
  type    = string
  default = "East US"
}

variable "vnet_name" {
  type    = string
  default = "azureday1-vnet"
}

variable "vnet_address_space" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}

# variable "vnet_dns_servers" {
#   type    = list(any)
#   default = ["10.0.0.4", "10.0.0.5"]
# }

variable "vnet_tag_name" {
  type = map(any)
  default = {
    environment = "demo"
  }
}