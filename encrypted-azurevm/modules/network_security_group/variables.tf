variable "subnet_nsg_name" {
  type    = string
  default = "tf-nsg"
}

variable "subnet_nsg_location" {
  type    = string
  default = "EastUS"
}

variable "subnet_nsg_resource_group_name" {
  type    = string
  default = "tftest-resources"
}
