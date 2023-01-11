variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "tftest"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "East US"
}

variable "username" {
  description = "The username to log in"
  default     = "azureuser"
}

variable "password" {
  description = "The password to log in"
  default     = "VMware1!SDDC"
}