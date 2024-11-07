variable "vnet_name" {
  default     = "az-vnet-default"
  description = "Virtual network name"
  type        = string
}

variable "vnet_address_space" {
  default     = ["10.0.0.0/16"]
  description = "Virtual network address space"
  type        = list(string)
}

variable "web_subnet_name" {
  default     = "websubnet"
  description = "Virtual Network Web subnet name"
  type        = string

}

variable "web_subnet_address" {
  default     = ["10.0.1.0/24"]
  description = "Virtual network web subnet Address Space"
  type        = list(string)
}

variable "app_subnet_name" {
  default     = "appsubnet"
  description = "Virtual Network App Subnet"
  type        = string
}

variable "app_subnet_address" {
  default     = ["10.0.11.0/24"]
  description = "Virtual network app subnet address space"
  type        = list(string)
}

variable "db_subnet_name" {
  default     = "dbsubnet"
  type        = string
  description = "Virtual Network DB subnet"
}

variable "db_subnet_address" {
  default     = ["10.0.21.0/24"]
  type        = list(string)
  description = "Virtual network Database Address space"
}

variable "bastion_subnet_name" {
  default     = "bastionsubnet"
  type        = string
  description = "Virtual network bastion subnet name"
}
variable "bastion_subnet_address" {
  default     = ["10.0.100.0/24"]
  description = "Bastion subnet address space"
  type        = list(string)

}