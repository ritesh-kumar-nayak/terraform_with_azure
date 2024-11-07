variable "vm_name" {
    default = "web_azlinux_vm"
    type = string
  
}

variable "host_name" {
    default = "webazlinux"
    type = string
  
}

variable "linux_admin_username" {
    default = "azureuser"
    type = string
  
}

variable "vm_size" {
    default = "Standard_DS1_v2"
    type = string
}