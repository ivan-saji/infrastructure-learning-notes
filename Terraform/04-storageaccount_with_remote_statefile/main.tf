terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "rg-tf-backend"
      storage_account_name = "tfbackendstatestorage01"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg02" {
  name     = "tf-rg-02"
  location = "Central India"
}

resource "azurerm_storage_account" "storage01" {
  name                     = "tfstorageaccount00021211"
  resource_group_name      = azurerm_resource_group.rg02.name
  location                 = azurerm_resource_group.rg02.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
