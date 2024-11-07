resource "azurerm_lb" "app_internal_lb" {
  name                = "${local.resource_name_prefix}-app-internal-lb"
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  resource_group_name = azurerm_resource_group.rg.name
  frontend_ip_configuration {
    name                          = "app-lb-privateip-1"
    subnet_id                     = azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.11.241" #"10.1.11.241"
    private_ip_address_version    = "IPv4"

  }

}
# Create backen pool
resource "azurerm_lb_backend_address_pool" "app_internal_lb_address_pool" {
  name            = "app-backend"
  loadbalancer_id = azurerm_lb.app_internal_lb.id

}
# Create LB Probe
resource "azurerm_lb_probe" "app_internal_lb_probe" {
  name            = "tcp-probe"
  protocol        = "Tcp"
  port            = 80
  loadbalancer_id = azurerm_lb.app_internal_lb.id

}
# Create LB Rule
resource "azurerm_lb_rule" "app_internal_lb_rule" {
  name                           = "app-app1-rule"
  protocol                       = "Tcp"
  backend_port                   = 80
  frontend_port                  = 80
  frontend_ip_configuration_name = azurerm_lb.app_internal_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.app_internal_lb_address_pool.id]
  probe_id                       = azurerm_lb_probe.app_internal_lb_probe.id
  loadbalancer_id                = azurerm_lb.app_internal_lb.id

}