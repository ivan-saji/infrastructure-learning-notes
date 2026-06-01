resource "azurerm_nat_gateway" "example" {
  name                    = local.nat_gateway_name
  location                = local.location
  resource_group_name     = local.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}