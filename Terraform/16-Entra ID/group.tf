resource "azuread_group" "department" {

  for_each = local.departments_list

  display_name     = each.value
  security_enabled = true

  #Enable dynamic membership for the group based on the department
  types = ["DynamicMembership"]

  #define the rule for dynamic membership based on the department
  rule = "user.department -eq \"${each.value}\" and user.accountEnabled -eq true"
  }