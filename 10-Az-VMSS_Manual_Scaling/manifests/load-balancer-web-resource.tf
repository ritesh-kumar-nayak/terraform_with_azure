# 1- Create Public IP Address for Azure Load Balancer
resource "azurerm_public_ip" "lb_web_publicip" {
  name                = "${local.resource_name_prefix}-web-lb-publicip"
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  tags                = local.common_tags

}
# 2- Create Azure Standard Load Balancer
resource "azurerm_lb" "lb_web" {
  name                = "${local.resource_name_prefix}-lb-web"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  # We can add multiple IP configuration block and allocate multiple public IP to a single  load balancer
  frontend_ip_configuration {
    public_ip_address_id = azurerm_public_ip.lb_web_publicip.id
    name                 = "lb_web_ip_config-1"
  }
}
# 3- Create Load Balancer Backend Pool
resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  name            = "lb-web-backend"
  loadbalancer_id = azurerm_lb.lb_web.id
}
# 4- Create Load Balancer Probe
resource "azurerm_lb_probe" "lb_web_probe" {
  name            = "tcp_probe"
  loadbalancer_id = azurerm_lb.lb_web.id
  port            = 80
  protocol        = "Tcp"
}
# 5- Create Load Balancer Rule
resource "azurerm_lb_rule" "lb_rule_app1" {
  name                           = "lb-web-rule-app1"
  backend_port                   = 80
  frontend_port                  = 80
  loadbalancer_id                = azurerm_lb.lb_web.id
  protocol                       = "Tcp"
  frontend_ip_configuration_name = azurerm_lb.lb_web.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.lb_web_probe.id
}

/* Commenting  the Network Interface and Standard Load Balancer association as the loadbalancer will be associated with VMSS Backend pool now which is taken care at the time of web-vmss-resource creation */

# # 6- Associate Network Interface and Standard Load Balancer
# resource "azurerm_network_interface_backend_address_pool_association" "lb_web_nic_backendpool_association" {
#   #count                   = var.web_linux_instance_count
#   for_each                = var.web_linux_instance_count
#   network_interface_id    = azurerm_network_interface.web_linuxvm_NIC[each.key].id
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_address_pool.id
#   ip_configuration_name   = azurerm_network_interface.web_linuxvm_NIC[each.key].ip_configuration[0].name
# }