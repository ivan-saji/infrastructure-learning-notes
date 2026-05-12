resource "azurerm_storage_account" "az_storage_acc02" {

  lifecycle {
    create_before_destroy = true
    # prevent_destroy = true
    precondition {
      condition = contains(var.allowed_locations,var.location)
      error_message = "The specified location is not allowed"
    }
  }

  # Using count to create multiple storage accounts based on the length of the storageaccount_name variable
  #count = length(var.storageaccount_name)
  #name = var.storageaccount_name[count.index]

  #using for_each to create multiple storage accounts based on the storageaccount_name variable

  for_each = var.storageaccount_name
  name     = each.value

  resource_group_name      = azurerm_resource_group.rg01.name
  location                 = azurerm_resource_group.rg01.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.common_tags.environment
    created_by  = var.common_tags.created_by
  }
}
