resource "azurerm_network_security_group" "testnsg01" {
# using ternary operator to set the name of NSG based on location variable
  name                = var.location == "Central India" ? "IndiaNSG" : "OutSideNSG"
  location            = var.location
  resource_group_name = var.resource_group_name

#using dynamic block to create security rules based on the local variable nsg_rules which is a map of security rules
  dynamic "security_rule" {

    for_each = local.nsg_rules

    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

  }

  tags = {
    environment = "Production"
  }
}
