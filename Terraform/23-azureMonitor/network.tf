resource "azurerm_resource_group" "rg02" {
  name     = "rg02-vnet-peering"
  location = "East US"
}
#-------------------------------------------------------------------
#Virtual Network 1
resource "azurerm_virtual_network" "vnet01" {
  name                = "vnet01"
  resource_group_name = azurerm_resource_group.rg02.name
  location            = azurerm_resource_group.rg02.location
  address_space       = ["10.0.0.0/16"]
}

#Subnet in VNet 1
resource "azurerm_subnet" "vnet01-default-subnet" {
  name                 = "vnet01-default-subnet"
  resource_group_name  = azurerm_resource_group.rg02.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.0.1.0/24"]
}
