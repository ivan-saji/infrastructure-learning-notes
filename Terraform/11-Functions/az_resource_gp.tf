resource "azurerm_resource_group" "rg01" {

  name     = var.resource_group_name
  location = var.location

  tags = { "create_date" = timestamp() }
}