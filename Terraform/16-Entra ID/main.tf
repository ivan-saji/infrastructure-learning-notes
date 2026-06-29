#Retrieve data from Azure AD using data source

data "azuread_domains" "aad" {
  only_initial = true
}

locals {
  domain_name = data.azuread_domains.aad.domains[0].domain_name
}

output "azuread_domains" {
  value = local.domain_name
}