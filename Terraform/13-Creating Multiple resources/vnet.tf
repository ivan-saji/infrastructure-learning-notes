resource "azurerm_virtual_network" "rg02-vnet01-infra" {
  name                = local.vnet_name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = local.vnet_address_space

  tags = {
    environment = local.environment
  }
}

#define subnet seperately for code flexibility
resource "azurerm_subnet" "rg02-vnet01-snet01-infra" {
  name                 = local.subnet1_name
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.rg02-vnet01-infra.name
  address_prefixes     = [local.subnet1_address_prefix]
}

#Associate NSG to Subnet
resource "azurerm_subnet_network_security_group_association" "rg02-vnet01-snet01-nsg01-infra" {
  subnet_id                 = azurerm_subnet.rg02-vnet01-snet01-infra.id
  network_security_group_id = azurerm_network_security_group.rg02-vnet01-snet01-nsg01-infra.id
}

#Associate Nat Gateway to Subnet
resource "azurerm_subnet_nat_gateway_association" "rg02-vnet01-snet01-natgw01-infra" {
  subnet_id      = azurerm_subnet.rg02-vnet01-snet01-infra.id
  nat_gateway_id = azurerm_nat_gateway.rg02-vnet01-snet01-natgw01-infra.id
}