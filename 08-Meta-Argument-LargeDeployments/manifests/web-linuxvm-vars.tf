variable "vm_name" {
  default = "web_azlinux_vm"
  type    = string

}

variable "host_name" {
  default = "webazlinux"
  type    = string

}

variable "linux_admin_username" {
  default = "azureuser"
  type    = string

}

variable "vm_size" {
  default = "Standard_DS1_v2"
  type    = string
}
variable "web_linux_instance_count" {
  default     = 1
  type        = number
  description = "number of vms"

}
variable "web_lb_inbound_nat_ports" {
  default     = ["1022", "2022", "3022", "4022", "5022"]
  description = "Web Load Balancer NAT Port List"
  

}