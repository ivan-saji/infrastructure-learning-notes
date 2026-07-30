#Mention the resource group here

resource "azurerm_resource_group" "rg01" {
  name     = "rg01"
  location = "central india"
}
