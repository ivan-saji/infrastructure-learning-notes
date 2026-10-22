#Creating a resource group to test tag policy

#addition of this RG will work as it is having tags as required
resource "azurerm_resource_group" "rg_test" {
  name     = "testrg"
  location = "West Europe"

  tags = {
    department = "IT"
    project    = "Terraform"
  }
}

#addition of this RG will not work as it is having tags as required
resource "azurerm_resource_group" "rg_test1" {
  name     = "testrg1"
  location = "West Europe"
}

resource "azurerm_resource_group" "rg_test2" {
  name     = "testrg2"
  location = "Canada Central"

  tags = {
    department = "IT"
    project    = "Terraform"
  }
}