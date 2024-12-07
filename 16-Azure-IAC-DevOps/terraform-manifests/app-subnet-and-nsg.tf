# Create App-Tier Subnet
resource "azurerm_subnet" "app_subnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_subnet_address
  resource_group_name  = azurerm_resource_group.rg.name

}
# Create NSG for Subnet
resource "azurerm_network_security_group" "app_snet_nsg" {

  name                = "${azurerm_subnet.app_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

# Associate app_subnet with app_snet_nsg

resource "azurerm_subnet_network_security_group_association" "associate_appsnet_appnsg" {
  depends_on                = [azurerm_network_security_rule.app_nsg_rules_inbound]
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_snet_nsg.id

}

# Locals block for security rules
locals {
  app_inbound_port_map = {
    # priority:port
    "100" : "80"
    "110" : "443"
    "120" : "8080"
    "130" : "22"

  }
}

# Create NSG Rules using azurerm_network_security_rule resource

resource "azurerm_network_security_rule" "app_nsg_rules_inbound" {
  for_each = local.app_inbound_port_map

  name                        = "Rule_Port_${each.value}"
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.app_snet_nsg.name
  priority                    = each.key
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix = "*"
  resource_group_name         = azurerm_resource_group.rg.name

}