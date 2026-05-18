variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "rg02"

}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "Central India"
}

variable "environment" {
  description = "The environment for which the resources are being created."
  type        = string
  default     = "prod"

  validation {
    condition = contains(["dev","staging","prod"],var.environment)
    error_message = "Enter valid environment value"
  }
}

variable "nsg_names" {
  description = "List of NSG names to be used for creating network security groups."
  type        = map(string)
  default     = {
    "dev"     = "nsg-dev"
    "staging" = "nsg-staging"
    "prod"    = "nsg-prod"
  }
}