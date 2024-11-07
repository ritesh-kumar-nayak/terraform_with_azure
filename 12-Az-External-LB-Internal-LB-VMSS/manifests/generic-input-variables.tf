# Business Division

variable "business_unit" {
  description = "Business area where this resource will be used"
  default     = "iaas-fs"
  type        = string
}

# Environment variables
variable "environment_dev" {
  description = "Environment in which the resources will be used"
  default     = "dev"
  type        = string
}

# Resource Group
variable "resource_group_name" {
  description = "Resource group where the resources will be created"
  type        = string
  default     = "iaas-terraform"
}

# location
variable "resource_group_location" {
  description = "Location where the resources will be deployed"
  default     = "eastus"
  type        = string
}
