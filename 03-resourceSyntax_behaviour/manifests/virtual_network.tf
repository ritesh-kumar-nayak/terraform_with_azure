# 1- Create Vnet resource
resource "azurerm_virtual_network" "vnet_1" {
  name                = "az_vnet1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  address_space       = ["10.0.0.0/16"] # Square bracket represents List. And address space can have multiple values separated by comma
  #dns_servers = ""

}

# 2- Create Subnet resource
resource "azurerm_subnet" "snet_1" {
  name                 = "az_snet1"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet_1.name
  address_prefixes     = ["10.0.2.0/24"]
}

# 3- Create Public IP
resource "azurerm_public_ip" "pubIp_1" {
  name                = "az_pubIp1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"
  tags = {
    "az_resource" = "PublicIP"
  }
}

# 4- Create Network Interface
resource "azurerm_network_interface" "nic_1" {
  name                = "az_nic1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  ip_configuration {
    name                          = "Internal"
    subnet_id                     = azurerm_subnet.snet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubIp_1.id
  }

}