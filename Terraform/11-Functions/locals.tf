locals {
  common_tags = {
    created_by = "Ivan"
    managed_by = "Terraform"
  }

  nsg_rules = {
    allow_http = {
      priority = 100
      port     = 80
      direction = "Inbound"
      access   = "Allow"
    }

    allow_https = {
      priority = 110
      port     = 443
      direction = "Inbound"
      access   = "Allow"
    }

    deny_8080 = {
      priority = 120
      port     = 8080
      direction = "Inbound"
      access   = "Deny"
    }
  }
}
