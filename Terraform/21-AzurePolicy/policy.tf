# Setup the policy here. 

data "azurerm_subscription" "current" {}

#Tag policy
resource "azurerm_policy_definition" "tagpolicy" {
  name         = "allowed-tags"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed tags policy"
  description  = "This policy enables you to restrict the tags your organization can specify when deploying resources."

  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          field  = "tags[${var.allowed_tags[0]}]"
          exists = false
        },
        {
          field  = "tags[${var.allowed_tags[1]}]",
          exists = false
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "tagassignment" {
  name                 = "allowed-tags-assignment"
  policy_definition_id = azurerm_policy_definition.tagpolicy.id
  subscription_id      = data.azurerm_subscription.current.id
}

#---------------------------------------
#VM Size Policy

resource "azurerm_policy_definition" "vmsizepolicy" {
  name         = "allowed-vm-sizes"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed VM sizes policy"
  description  = "This policy enables you to restrict the VM sizes your organization can specify when deploying virtual machines."

  policy_rule = jsonencode({
    if = {
      field = "Microsoft.Compute/virtualMachines/sku.name"
      notIn = var.allowed_vm_sizes
    }
    then = {
      effect = "deny"

    }
  })
}

resource "azurerm_subscription_policy_assignment" "vmsizeassignment" {
  name                 = "allowed-vm-sizes-assignment"
  policy_definition_id = azurerm_policy_definition.vmsizepolicy.id
  subscription_id      = data.azurerm_subscription.current.id
}

#---------------------------------------

#Location Policy

resource "azurerm_policy_definition" "locationpolicy" {
  name         = "allowed-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed locations policy"
  description  = "This policy enables you to restrict the locations your organization can specify when deploying resources."

  policy_rule = jsonencode({
    if = {
      field = "location"
      notIn = [var.location]
    }
    then = {
      effect = "deny"
    }
  })

}


resource "azurerm_subscription_policy_assignment" "locationassignment" {
  name                 = "allowed-locations-assignment"
  policy_definition_id = azurerm_policy_definition.locationpolicy.id
  subscription_id      = data.azurerm_subscription.current.id
}