#Create a resource group rg02-infra to apply the roles

resource "azurerm_resource_group" "rg02_infra" {
  name     = "rg02-infra"
  location = "East US"
}