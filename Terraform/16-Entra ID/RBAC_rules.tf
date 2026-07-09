#This is where all the RBAC rules sits

resource "azurerm_role_assignment" "rg02_infra_contributor" {
  scope                = azurerm_resource_group.rg02_infra.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.department["Engineering"].object_id
}