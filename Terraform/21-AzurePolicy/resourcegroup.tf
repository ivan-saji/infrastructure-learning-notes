#Creating a resource group to test tag policy

#addition of this RG will work as it is having tags as required
resource "azurerm_resource_group" "rg_test" {
  name     = "testrg"
  location = "West Europe"

  tags = {
    department = "IT"
    project    = "Terraform"
  }

  depends_on = [
    azurerm_subscription_policy_assignment.locationassignment,
    azurerm_subscription_policy_assignment.tagassignment,
    azurerm_subscription_policy_assignment.vmsizeassignment
  ]
}

#addition of this RG will not work as it is having tags as required
resource "azurerm_resource_group" "rg_test1" {
  name     = "testrg1"
  location = "West Europe"

  depends_on = [
    azurerm_subscription_policy_assignment.locationassignment,
    azurerm_subscription_policy_assignment.tagassignment,
    azurerm_subscription_policy_assignment.vmsizeassignment
  ]
}

resource "azurerm_resource_group" "rg_test2" {
  name     = "testrg2"
  location = "Canada Central"

  depends_on = [
    azurerm_subscription_policy_assignment.locationassignment,
    azurerm_subscription_policy_assignment.tagassignment,
    azurerm_subscription_policy_assignment.vmsizeassignment
  ]

  tags = {
    department = "IT"
    project    = "Terraform"
  }
}