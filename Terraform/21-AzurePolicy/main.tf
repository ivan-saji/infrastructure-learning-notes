# Setup the policy here. 

data "azurerm_subscription" "current" {}

resource "azurerm_policy_definition" "azurelocationpolicy" {
  name         = "only-deploy-in-westeurope"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed resource locations"

  policy_rule = jsonencode({
    "if" = {
        "field" = "location",
        "notIn"= ["${var.location}"]
    },
    "then" = {
      "effect" = "deny"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "azurelocationpolicy" {
  name                 = "azurelocationpolicy"
  policy_definition_id = azurerm_policy_definition.azurelocationpolicy.id
  subscription_id      = data.azurerm_subscription.current.id
}