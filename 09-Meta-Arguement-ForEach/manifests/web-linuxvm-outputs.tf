# output "weblinux_publicip" {
#     value = azurerm_public_ip.web_linuxvm_publicip.ip_address
#     description = "Public Ip of the VM"

# }

# Output LIST - Single Input to for loop
output "weblinux_private_ip_address_list" {
  value       = [for vm in azurerm_linux_virtual_machine.web_linuxvm : vm.private_ip_addresses] # Output is going to be a list
  description = "List of private IP using for loop"
}

# Output MAP - Single Input to for loop
output "weblinux_privateIP_address_map" {
  value = { for vm in azurerm_linux_virtual_machine.web_linuxvm : vm.name => vm.private_ip_addresses }
  #  key          value
  description = "Map of vm name and private ip using for loop"
  # => is the operator to generate the map format. 
}

# Terraform keys() function
output "weblinux_privateip_keyFunction" {
  value       = keys({ for vm in azurerm_linux_virtual_machine.web_linuxvm : vm.name => vm.private_ip_addresses })
  description = "Returns the key of the map i.e. the vm name"
}
# Terraform values() function
output "weblinux_privateip_valuesFunction" {
  value = values({ for vm in azurerm_linux_virtual_machine.web_linuxvm : vm.name => vm.private_ip_addresses })
}

# Output List - Two Inputs to for loop (here vm is the iterator )
output "weblinux_networkinterface_id_list" {

  value       = [for vm, nic in azurerm_network_interface.web_linuxvm_NIC : nic.id] #here it will be displayed as list [nic_id_1, nic_id_2]
  description = "Weblinux vm interface id in list format"
}

output "weblinux_networkinterface_id_map" {

  value       = { for vm, nic in azurerm_network_interface.web_linuxvm_NIC : vm => nic.id } # here it will be displayed as map vm:nic_id
  description = "Weblinux vm interface id in map format"
}

# #Network interface id
# output "weblinux_networkinterface_id" {
#   value       = azurerm_network_interface.web_linuxvm_NIC[*].id
#   description = "Interface id of NIC"

# }
# output "weblinux_networkinterface_privateip" {
#   value       = [azurerm_network_interface.web_linuxvm_NIC[*].private_ip_addresses]
#   description = "Interface private IPs"
# }

# output "weblinux_vm_id" {
#   value       = azurerm_linux_virtual_machine.web_linuxvm[*].id
#   description = "VM Id"

# }
# output "weblinux_vm_publicip" {
#     value = azurerm_linux_virtual_machine.web_linuxvm.public_ip_address
#     description = "VM Public IP address"

# }