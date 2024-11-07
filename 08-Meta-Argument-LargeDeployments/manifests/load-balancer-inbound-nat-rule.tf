resource "azurerm_lb_nat_rule" "lb_web_inbound_nat_rule_22" {
  count                          = var.web_linux_instance_count
  name                           = "vm${count.index}-ssh-${var.web_lb_inbound_nat_ports[count.index]}-22"
  depends_on                     = [azurerm_linux_virtual_machine.web_linuxvm]
  backend_port                   = 22 # LoadBalancer port which will be mapped to port 22 of VM
  frontend_port                  = element(var.web_lb_inbound_nat_ports, count.index)
  frontend_ip_configuration_name = azurerm_lb.lb_web.frontend_ip_configuration[0].name
  loadbalancer_id                = azurerm_lb.lb_web.id
  protocol                       = "Tcp"
  resource_group_name            = azurerm_resource_group.rg.name
}
resource "azurerm_network_interface_nat_rule_association" "lb_nic_nat_rule_associate" {
  count = var.web_linux_instance_count

  nat_rule_id = element(azurerm_lb_nat_rule.lb_web_inbound_nat_rule_22[*].id, count.index)

  network_interface_id  = element(azurerm_network_interface.web_linuxvm_NIC[*].id, count.index)
  ip_configuration_name = element(azurerm_network_interface.web_linuxvm_NIC[*].ip_configuration[0].name, count.index)

}