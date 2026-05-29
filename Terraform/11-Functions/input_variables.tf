# resource_group_name and location are loaded from config.json via locals.
# They are not valid to assign as variable defaults from dynamic expressions.

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