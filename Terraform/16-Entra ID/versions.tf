# Configure Terraform to use azureAD provider
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.7.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}

  subscription_id = "86325090-0264-4868-9a75-0df86c5f215f"
}