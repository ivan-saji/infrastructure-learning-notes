variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "rg01"
}

variable "common_tags" {
  description = "A map of common tags to apply to all resources."
  type        = map(string)
  default = {
    environment = "Test"
    created_by  = "Ivan"
  }

}

#using list to create multiple storage accounts with count

#variable "storageaccount_name" {
#  description = "The name of the storage account to create."
# type        = list(string)
# default     = ["tfstorageaccount0001", "tfstorageaccount0002", "tfstorageaccount0003"]
#}

#using set to create multiple storage accounts with for_each to avoid duplicates
variable "storageaccount_name" {
  description = "The name of the storage account to create."
  type        = set(string)
  default     = ["tfstorageaccount0001", "tfstorageaccount0002", "tfstorageaccount0003"]
}
