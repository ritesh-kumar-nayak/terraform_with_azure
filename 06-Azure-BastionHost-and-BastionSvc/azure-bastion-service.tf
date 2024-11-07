# Azure Bastion Subnet

resource "azurerm_subnet" "az_bastion_service_subnet" {
  name                 = var.az_bastion_service_subnet_name # Name cant be anything other than "AzureBastionSubnet".
  address_prefixes     = var.az_bastion_service_address_prefixes
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

}

# Azure Bastion Public IP
resource "azurerm_public_ip" "az_bastion_public_ip" {
  name                = "${local.resource_name_prefix}-${var.az_bastion_service_public_ip}"
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

}
# Azure Bastion Service Host

resource "azurerm_bastion_host" "az_bastion_host_svc" {
  name                = "${local.resource_name_prefix}-${var.az_bastion_service_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  ip_configuration {
    name                 = "bastion_ip_config"
    subnet_id            = azurerm_subnet.az_bastion_service_subnet.id
    public_ip_address_id = azurerm_public_ip.az_bastion_public_ip.id
  }

}