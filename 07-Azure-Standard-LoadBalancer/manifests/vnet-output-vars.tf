# Vnet required outputs

output "virtual_network_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Virtual network name"

}
output "virtual_network_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Virtual network id"

}

# Web Subnet outputs
output "web_subnet_name" {
  value       = azurerm_subnet.web_subnet.name
  description = "Web subnet name"

}
output "web_subnet_id" {
  value       = azurerm_subnet.web_subnet.id
  description = "Web subnet id"

}

# web NSG outputs
output "web_nsg_name" {
  value       = azurerm_network_security_group.web_snet_nsg.name
  description = "Web NSG name"

}
output "web_nsg_id" {
  value       = azurerm_network_security_group.web_snet_nsg.id
  description = "Web NSG id"

}