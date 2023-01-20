variable "disk_encryption_set_name" {
  type    = string
  default = "tf-des"
}

variable "disk_encryption_set_resource_group_name" {
  type    = string
  default = "tf-resources"
}

variable "disk_encryption_set_location" {
  type    = string
  default = "EastUS"
}

variable "disk_encryption_set_keyvaultkey_id" {
  type    = string
  default = "keyvault_id"
}

