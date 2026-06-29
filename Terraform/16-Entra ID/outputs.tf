output "azuread_domains" {
  value = local.domain_name
}

#Step 3 : Output the users list from the CSV file
output "user_name_from_fromList" {
  value = [for user in local.users_list : "${user.first_name}"]
}
