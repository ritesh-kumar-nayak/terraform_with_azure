resource "azurerm_network_interface" "web_linuxvm_NIC" {
  name = "${local.resource_name_prefix}-${var.nic_name}"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # We can add multiple IP configuration for a single VM. We can keep adding multiple ip_configuration blocks
  ip_configuration {

    name                          = var.ip_config_1
    private_ip_address_allocation = var.ip_allocation_type
    subnet_id                     = azurerm_subnet.web_subnet.id
    #public_ip_address_id = azurerm_public_ip.web_linuxvm_publicip.id 
    /* Public ip address is being disabled as this is our workload vm and we are not supposed to expose the public ip instead use bastion host or bastion service that we are going to deploy as part of this.*/

    # primary = true # this needs to be flagged explicitly when you are having multiple ip_configuration blocks
  }

}