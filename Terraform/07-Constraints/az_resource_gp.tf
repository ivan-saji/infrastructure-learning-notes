resource "azurerm_resource_group" "rg01" {
  name     = "tf-rg-01"
  location = var.location
  tags = {
    environment = var.environment
    created_by = local.common_tags.created_by
  }
}