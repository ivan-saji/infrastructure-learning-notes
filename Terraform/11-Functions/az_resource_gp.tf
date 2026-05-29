resource "azurerm_resource_group" "rg01" {

  name     = local.config.resource_group_name
  location = local.config.location

  tags = { "create_date" = timestamp() }
}