resource "azurerm_resource_group" "rg02" {
  name     = "rg02-vnet-peering"
  location = "East US"
}
#-------------------------------------------------------------------



#Virtual Network 1
resource "azurerm_virtual_network" "vnet" {

count = 2

  name                = "vnet${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg02.name
  location            = azurerm_resource_group.rg02.location

  address_space       = ["10.${count.index}.0.0/16"]
}

#Subnet in VNet 1
resource "azurerm_subnet" "vnet-default-subnet" {
count = 2

  name                 = "vnet${count.index + 1}-default-subnet"
  resource_group_name  = azurerm_resource_group.rg02.name
  virtual_network_name = azurerm_virtual_network.vnet[count.index].name
  address_prefixes     = ["10.${count.index}.1.0/24"]
}

