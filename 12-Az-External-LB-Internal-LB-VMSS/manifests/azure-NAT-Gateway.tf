#Create Public IP for Nat Gateway
resource "azurerm_public_ip" "nat_gateway_publicip" {
  name                = "${local.resource_name_prefix}-natgtw_publicip"
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

}
# Create NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway_appsnet" {
  name                = "${local.resource_name_prefix}-app-svc-nat-gateway"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# Associate NAT gateway and public ip
resource "azurerm_nat_gateway_public_ip_association" "associate_natgtw_publicip" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway_appsnet.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_publicip.id

}
# Associate App Subnet and Azure NAT Gateway
resource "azurerm_subnet_nat_gateway_association" "associate_natgtw_app_snet" {
  subnet_id      = azurerm_subnet.app_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway_appsnet.id

}