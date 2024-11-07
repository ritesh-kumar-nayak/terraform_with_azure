variable "nic_name" {
  default = "linuxvm-nic"
  type    = string
}

variable "ip_allocation_type" {
  default = "Dynamic"
  type    = string
}

variable "ip_config_1" {
  default = "web_linuxvm_ip_1"
  type    = string

}