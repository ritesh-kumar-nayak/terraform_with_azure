# Create Web-Tier Subnet
resource "azurerm_subnet" "web_subnet" {

  name                 = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes    = var.web_subnet_address # Referenced from vnet-input-variables
  resource_group_name = azurerm_resource_group.rg.name

}
# Create NSG for web_subnet

resource "azurerm_network_security_group" "web_snet_nsg" {

  name                = "${azurerm_subnet.web_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

# Associate web_subnet with web_snet_nsg

resource "azurerm_subnet_network_security_group_association" "associate_websnet_webnsg" {
  depends_on                = [azurerm_network_security_rule.web_nsg_rules_inbound]
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_snet_nsg.id

}

# Locals block for security rules
locals {
  web_inbound_port_map = {
    # priority:port
    "100" : "80"
    "110" : "443"
    "120" : "22"

  }
}
# Create NSG Rules using azurerm_network_security_rule resource

resource "azurerm_network_security_rule" "web_nsg_rules_inbound" {
  for_each = local.web_inbound_port_map

  name                        = "Rule_Port_${each.value}"
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.web_snet_nsg.name
  priority                    = each.key
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name

}