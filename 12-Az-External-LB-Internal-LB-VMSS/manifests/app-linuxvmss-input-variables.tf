variable "app_vmss_nsg_inbound_ports" {
  description = "app vmss inbound ports"
  type        = list(string)
  default     = ["22", "80", "443"]

}