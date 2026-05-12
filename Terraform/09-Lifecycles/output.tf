output "rgname" {
  value = azurerm_resource_group.rg01.name
}

#using for expression to output the names of all storage accounts created with for_each
output "storage_account_names" {
  value = [for i in azurerm_storage_account.az_storage_acc02 : i.name]
}