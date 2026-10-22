#Mention the variables here

variable "allowed_tags" {
  description = "List of allowed tags for resources."
  type        = list(string)
  default     = ["department", "project"]
}

variable "allowed_vm_sizes" {
  description = "List of allowed VM sizes for virtual machines."
  type        = list(string)
  default     = ["Standard_B1s", "Standard_B2s"]
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West Europe"
}