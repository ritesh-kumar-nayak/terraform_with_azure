variable "web_linuxvm_publicip_name" {
    type = string
    default = "web-linuxvm-publicip"
}

variable "allocation_type" {
    default = "Static"
    type = string
  
}

variable "sku_type" {
    default = "Standard"
    type = string
  
}

variable "domain_name" {
    default = "devopswithritesh"
    type = string
  
}