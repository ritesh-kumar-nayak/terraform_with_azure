# terraform doc: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway

#Required_Resource-: Azure Application Gateway Public IP
resource "azurerm_public_ip" "web_application_gateway_publicip" {
  name                = "${local.resource_name_prefix}-web-ag-publicip"
  allocation_method   = "Static"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
}
# Azure AG Locals Block
locals {
  # Generic
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feipconfig"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-httplistener"
  request_routing_rule1_name     = "${azurerm_virtual_network.vnet.name}-requestrouting1"
  # When you have multiple applications attached to a Application gateway you have to arrange the naming accordingly

  # we are also going to perfrom context-path based routing using application gateway which means when request comes to /app1 traffic will go to app1 vmss and if request comes to /app2 then traffic will go to app2 vmss 

  # App1
  backend_address_pool_name_app1 = "${azurerm_virtual_network.vnet.name}-bepap_app1"
  http_setting_name_app1         = "${azurerm_virtual_network.vnet.name}-behttpsettung_app1"
  probe_name_app1                = "${azurerm_virtual_network.vnet.name}-beprobe_app1"

}

# Resource-: Azure Application Gateway
resource "azurerm_application_gateway" "web_application_gateway" {
  name                = "${local.resource_name_prefix}-web_application_gateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
    #capacity = 3 This property is optional if autoscale_configuration is set.

  }
  autoscale_configuration {
    min_capacity = 0
    max_capacity = 10 # we can go till 125 for Standard_v2 sku
  }

  gateway_ip_configuration {
    name      = "ag_ip_config"
    subnet_id = azurerm_subnet.ag_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.web_application_gateway_publicip.id
    #subnet_id            = azurerm_subnet.ag_subnet.id
  }
  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"

  }

  # App1 Config
  backend_address_pool {
    name = local.backend_address_pool_name_app1
  }
  backend_http_settings {
    name                  = local.http_setting_name_app1
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
    probe_name            = local.probe_name_app1
  }
  probe {
    name                = local.probe_name_app1
    host                = "127.0.0.1"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    protocol            = "Http"
    port                = 80
    path                = "/app1/status.html"
    match {
      body        = "App1"
      status_code = ["200"]
    }

  }
  request_routing_rule {
    name                       = local.request_routing_rule1_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name_app1
    backend_http_settings_name = local.http_setting_name_app1
    priority = 1

  }


}