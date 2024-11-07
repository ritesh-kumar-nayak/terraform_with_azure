# output "weblinux_publicip" {
#     value = azurerm_public_ip.web_linuxvm_publicip.ip_address
#     description = "Public Ip of the VM"

# }

#Network interface id
output "weblinux_networkinterface_id" {
  value       = azurerm_network_interface.web_linuxvm_NIC[*].id
  description = "Interface id of NIC"

}
output "weblinux_networkinterface_privateip" {
  value       = [azurerm_network_interface.web_linuxvm_NIC[*].private_ip_addresses]
  description = "Interface private IPs"
}

output "weblinux_vm_id" {
  value       = azurerm_linux_virtual_machine.web_linuxvm[*].id
  description = "VM Id"

}
# output "weblinux_vm_publicip" {
#     value = azurerm_linux_virtual_machine.web_linuxvm.public_ip_address
#     description = "VM Public IP address"

# }