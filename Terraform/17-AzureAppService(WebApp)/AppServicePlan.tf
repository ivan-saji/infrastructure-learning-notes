#Mention the App Service plan here

resource "azurerm_service_plan" "asp1" {
  name                = "asp1"
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# Mention the App service here
resource "azurerm_linux_web_app" "asp1_webapp" {
  name                = "asp1-webapp"
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_service_plan.asp1.location
  service_plan_id     = azurerm_service_plan.asp1.id

  site_config {}
}

#Create a deployment slot

resource "azurerm_linux_web_app_slot" "asp1_webapp_slot" {
  name                = "staging"
  service_plan_id     = azurerm_service_plan.asp1.id
  app_service_id      = azurerm_linux_web_app.asp1_webapp.id

  site_config {}
}