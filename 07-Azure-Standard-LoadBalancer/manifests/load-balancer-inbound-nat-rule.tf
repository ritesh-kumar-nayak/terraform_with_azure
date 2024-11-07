resource "azurerm_lb_nat_rule" "lb_web_inbound_nat_rule_22" {
    name = "ssh-1022-vm-22"
    backend_port = 22   # LoadBalancer port which will be mapped to port 22 of VM
    frontend_port = 1022
    frontend_ip_configuration_name = azurerm_lb.lb_web.frontend_ip_configuration[0].name
    loadbalancer_id = azurerm_lb.lb_web.id
    protocol = "Tcp"
    resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_network_interface_nat_rule_association" "lb_nic_nat_rule_associate" {
 nat_rule_id = azurerm_lb_nat_rule.lb_web_inbound_nat_rule_22.id
 network_interface_id = azurerm_network_interface.web_linuxvm_NIC.id
 ip_configuration_name =  azurerm_network_interface.web_linuxvm_NIC.ip_configuration[0].name

}