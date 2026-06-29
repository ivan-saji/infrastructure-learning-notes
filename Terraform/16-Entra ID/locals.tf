locals {
  domain_name = data.azuread_domains.aad.domains[0].domain_name

  #Step 2 : Trying to fetch the users list from the CSV file
  users_list = csvdecode(file("${path.module}/users.csv"))
}