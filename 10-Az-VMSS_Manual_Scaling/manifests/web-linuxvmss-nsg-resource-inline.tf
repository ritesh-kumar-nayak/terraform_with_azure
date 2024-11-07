resource "azurerm_network_security_group" "web_vmss_nsg" {
    name = "${local.resource_name_prefix}-web-vmss-nsg"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    dynamic "security_rule" {
      for_each = var.web_vmss_nsg_inbound_ports
      content {
        name = "Inbound_rule_http-${security_rule.key}"
        description = "Inbound Rule-${security_rule.key}"
        priority = sum([100,security_rule.key ]) # security_rule.key returns index number and sum() function sums up 100 withe the value returned. This way works only when there is a list of string
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = security_rule.value
        source_address_prefix = "*"
        destination_address_prefix = "*"

      }
    }
}