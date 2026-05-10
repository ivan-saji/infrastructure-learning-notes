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

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "Central India"
}

variable "environment" {
  description = "The environment for which resources are being provisioned (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

resource "azurerm_resource_group" "rg01" {
  name     = "tf-rg-01"
  location = var.location
  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_account" "storage01" {
  name                     = "tfstorageaccount00021211"
  resource_group_name      = azurerm_resource_group.rg01.name
  location                 = azurerm_resource_group.rg01.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
  }
}
