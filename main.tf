terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "pzal" {
  name     = "heat_island"
  location = "swedencentral"
}

resource "azurerm_storage_account" "heat_storage" {
  name                     = "urbanheatisland${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.pzal.name
  location                 = azurerm_resource_group.pzal.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier = "Hot"
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}
