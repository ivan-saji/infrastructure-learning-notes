#Retrieve data from Azure AD using data source

data "azuread_domains" "aad" {
  only_initial = true
}

#Create users from the list
resource "azuread_user" "user" {
  for_each = { for user in local.users_list : user.first_name => user }

  user_principal_name = lower("${substr(each.value.department, 0, 1)}${substr(each.value.job_title, 0, 1)}${substr(each.value.first_name, 0, 3)}@${local.domain_name}")
  display_name        = "${each.value.first_name} ${each.value.last_name}"
  mail_nickname       = each.value.first_name
  password            = "Password123!"

  force_password_change = true
}
