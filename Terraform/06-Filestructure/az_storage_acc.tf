resource "azurerm_storage_account" "storage01" {
  name                     = "tfstorageaccount00021211"
  resource_group_name      = azurerm_resource_group.rg01.name
  location                 = azurerm_resource_group.rg01.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment                   #Using variable for environment tag
    created_by = local.common_tags.created_by       # Using local variable for common tag
  }
}
