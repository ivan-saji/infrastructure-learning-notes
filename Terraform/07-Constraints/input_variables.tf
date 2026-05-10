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