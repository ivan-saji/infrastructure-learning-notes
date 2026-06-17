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

#----------------------------------------------------------------------

#Virtual Network 2
resource "azurerm_virtual_network" "vnet02" {
  name                = "vnet02"
  resource_group_name = azurerm_resource_group.rg02.name
  location            = azurerm_resource_group.rg02.location
  address_space       = ["10.1.0.0/16"]
}

#Subnet in VNet 2
resource "azurerm_subnet" "vnet02-default-subnet" {
  name                 = "vnet02-default-subnet"
  resource_group_name  = azurerm_resource_group.rg02.name
  virtual_network_name = azurerm_virtual_network.vnet02.name
  address_prefixes     = ["10.1.1.0/24"]
}

#VNet Peering from VNet 1 to VNet 2
resource "azurerm_virtual_network_peering" "peering01" {
  name                      = "peering01"
  resource_group_name       = azurerm_resource_group.rg02.name
  virtual_network_name      = azurerm_virtual_network.vnet01.name
  remote_virtual_network_id = azurerm_virtual_network.vnet02.id
  allow_virtual_network_access = true
}

#VNet Peering from VNet 2 to VNet 1
resource "azurerm_virtual_network_peering" "peering02" {
  name                      = "peering02"
  resource_group_name       = azurerm_resource_group.rg02.name
  virtual_network_name      = azurerm_virtual_network.vnet02.name
  remote_virtual_network_id = azurerm_virtual_network.vnet01.id
  allow_virtual_network_access = true
}