resource "azurerm_network_security_group" "weblinuxvm_nsg" {
  name                = "${local.resource_name_prefix}-wbelinux_nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

}

# Locals block for security rules
locals {
  weblinux_inbound_port_map = {
    # priority:port
    "100" : "80"
    "110" : "443"
    "120" : "22"

  }
}
# Create Network Security Rule
resource "azurerm_network_security_rule" "weblinuxvm_nsg_rules" {
  for_each                    = local.weblinux_inbound_port_map
  access                      = "Allow"
  resource_group_name         = azurerm_resource_group.rg.name
  direction                   = "Inbound"
  name                        = "weblinux_rule_port_${each.value}"
  network_security_group_name = azurerm_network_security_group.weblinuxvm_nsg.name
  priority                    = each.key
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

# NSG and VM NIC
resource "azurerm_network_interface_security_group_association" "associate_weblinux_nsg_nic" {
  for_each                  = azurerm_network_interface.web_linuxvm_NIC
  depends_on                = [azurerm_network_security_rule.weblinuxvm_nsg_rules]
  network_interface_id      = each.value.id
  network_security_group_id = azurerm_network_security_group.weblinuxvm_nsg.id

}