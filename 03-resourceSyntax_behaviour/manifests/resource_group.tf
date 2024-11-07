resource "azurerm_resource_group" "rg1" {
  name     = "network_rg"
  location = "East US"
  tags = {
    "type" = "Networking"
    "location"="US"
  }

}