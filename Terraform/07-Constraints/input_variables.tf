variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "Central India"
}

variable "environment" {
  description = "The environment for which resources are being provisioned (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB."
  type        = number
  default     = 30
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16","192.168.0.0/16"]
}

variable "common_tags2" {
  description = "A map of common tags to apply to all resources."
  type        = map(string)
  default     = {
    created_by = "Terraform"
    project    = "Azure VM Provisioning"
  }
}


variable "vm_info" {
  type = tuple([
    string,
    number,
    bool
  ])

  default = [
    "Standard_B1s",
    30,
    true
  ]
}