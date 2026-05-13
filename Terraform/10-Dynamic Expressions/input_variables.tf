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
