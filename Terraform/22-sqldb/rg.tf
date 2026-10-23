#Mention the resource groups here

resource "azurerm_resource_group" "rg01" {
  name     = "rg01-sqldb"
  location = "South India"
}