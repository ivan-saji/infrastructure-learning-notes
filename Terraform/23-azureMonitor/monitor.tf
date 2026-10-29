resource "azurerm_resource_group" "monitor_rg" {
  name     = "monitor-rg"
  location = "East US"
}

resource "azurerm_storage_account" "monitor_sa" {
  name                     = "monitorstorageaccount"
  resource_group_name      = azurerm_resource_group.monitor_rg.name
  location                 = azurerm_resource_group.monitor_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_action_group" "rg_action_group" {
  name                = "rg-actiongroup"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "rgaction"

  email_receiver {
    name        = "sendtoadmin"
    email_address = "isajiabraham@gmail.com"
  }
}

resource "azurerm_monitor_metric_alert" "cpu" {
  name                = "cpu-metricalert"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [azurerm_storage_account.monitor_sa.id]
  description         = "Action will be triggered when CPU usage is greater than 70%."

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percent CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 70

    
  }

  action {
    action_group_id = azurerm_monitor_action_group.rg_action_group.id
  }
}