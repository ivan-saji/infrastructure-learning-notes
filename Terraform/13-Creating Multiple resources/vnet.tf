resource "azurerm_virtual_network" "rg02-vnet01-infra" {
  name                = local.vnet_name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = local.vnet_address_space

  subnet {
    name             = local.subnet1_name
    address_prefixes = [local.subnet1_address_prefix]
  }

  tags = {
    environment = local.environment
  }
}

#Associate NSG to Subnet
resource "azurerm_subnet_network_security_group_association" "rg02-vnet01-snet01-nsg01-infra" {
  subnet_id                 = azurerm_virtual_network.rg02-vnet01-infra.subnet.id
  network_security_group_id = azurerm_network_security_group.rg02-vnet01-snet01-nsg01-infra.id
}

#Associate Nat Gateway to Subnet
resource "azurerm_subnet_nat_gateway_association" "rg02-vnet01-snet01-natgw01-infra" {
  subnet_id      = azurerm_virtual_network.rg02-vnet01-infra.subnet.id
  nat_gateway_id = azurerm_nat_gateway.example.id
}