#Mention the App Service plan here

resource "azurerm_service_plan" "asp1" {
  name                = "asp1"
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  os_type             = "Linux"
  sku_name            = "St1"
}

# Mention the App service here
resource "azurerm_linux_web_app" "asp1_webapp" {
  name                = "asp1-webapp"
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_service_plan.asp1.location
  service_plan_id     = azurerm_service_plan.asp1.id

  site_config {
    always_on = false
  }
}

#Create a deployment slot apart from the default production

resource "azurerm_linux_web_app_slot" "asp1_webapp_slot" {
  name                = "staging"
  app_service_id      = azurerm_linux_web_app.asp1_webapp.id

  site_config {}
}

#Create the deployment for production

resource "azurerm_app_source_control" "asp1_webapp_source_control" {
  app_id                = azurerm_linux_web_app.asp1_webapp.id
  branch                = "main"
  repo_url              = "https://github.com/your-repo/your-app.git"
}

#create the deployment for staging slot
resource "azurerm_app_source_control" "asp1_webapp_staging_slot_source_control" {
  app_id                = azurerm_linux_web_app_slot.asp1_webapp_slot.id
  branch                = "staging"
  repo_url              = "https://github.com/your-repo/your-app.git"
}