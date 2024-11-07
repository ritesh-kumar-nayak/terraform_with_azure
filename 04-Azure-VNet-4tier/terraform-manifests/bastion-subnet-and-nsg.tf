# Create Bastion-Tier Subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.bastion_subnet_name}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_address
  resource_group_name  = azurerm_resource_group.rg.name

}

# Create NSG for Subnet
resource "azurerm_network_security_group" "bastion_snet_nsg" {

  name                = "${azurerm_subnet.bastion_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

# Associate bastion_subnet with bastion_snet_nsg

resource "azurerm_subnet_network_security_group_association" "associate_bastionsnet_bastionnsg" {
  depends_on                = [azurerm_network_security_rule.bastion_nsg_rules_inbound]
  subnet_id                 = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_snet_nsg.id

}

# Locals block for security rules
locals {
  bastion_inbound_port_map = {
    # priority:port
    "100" : "22"
    "110" : "3389"
  }
}

# Create NSG Rules using azurerm_network_security_rule resource

resource "azurerm_network_security_rule" "bastion_nsg_rules_inbound" {
  for_each = local.bastion_inbound_port_map

  name                        = "Rule_Port_${each.value}"
  access                      = "Allow"
  direction                   = "Inbound"
  network_security_group_name = azurerm_network_security_group.bastion_snet_nsg.name
  priority                    = each.key
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix = "*"
  resource_group_name         = azurerm_resource_group.rg.name

}