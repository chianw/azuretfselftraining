terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurecaf" {
  # Configuration options
}