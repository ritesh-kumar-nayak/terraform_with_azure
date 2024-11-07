resource "azurerm_lb_nat_rule" "lb_web_inbound_nat_rule_22" {
  #count                          = var.web_linux_instance_count
  for_each = var.web_linux_instance_count

  name         = "vm${each.key}-ssh-22"
  #depends_on   = [azurerm_linux_virtual_machine.web_linuxvm]
  backend_port = 22 # LoadBalancer port which will be mapped to port 22 of VM

  #frontend_port                  = each.value # directly using each.value - fist way

  frontend_port = lookup(var.web_linux_instance_count, each.key) # Here used lookup() function to refer the value. Lookup functio returns the value of the key defined as second parameter - second way

  frontend_ip_configuration_name = azurerm_lb.lb_web.frontend_ip_configuration[0].name
  loadbalancer_id                = azurerm_lb.lb_web.id
  protocol                       = "Tcp"
  resource_group_name            = azurerm_resource_group.rg.name
}
# resource "azurerm_network_interface_nat_rule_association" "lb_nic_nat_rule_associate" {
#   #count = var.web_linux_instance_count

#   for_each = var.web_linux_instance_count

#   nat_rule_id = azurerm_lb_nat_rule.lb_web_inbound_nat_rule_22[each.key].id

#   network_interface_id  = azurerm_network_interface.web_linuxvm_NIC[each.key].id
#   ip_configuration_name = azurerm_network_interface.web_linuxvm_NIC[each.key].ip_configuration[0].name

# }