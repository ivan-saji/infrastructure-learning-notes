resource "azuread_group" "department" {

  for_each = local.departments_list

  display_name     = each.value
  security_enabled = true

}

resource "azuread_group_member" "department_members" {

  for_each = {
    for user in local.users_list :
    user.first_name => user
  }

  group_object_id  = azuread_group.department[each.value.department].object_id
  member_object_id = azuread_user.user[each.value.first_name].object_id
 }