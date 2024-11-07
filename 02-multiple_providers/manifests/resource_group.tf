resource "azurerm_resource_group" "rg1-default" {
  location = "East US"
  name     = "rg-1-useast"
  tags = {
    region = "East"
  }
}

# uses the second region
resource "azurerm_resource_group" "rg2-west" {
  name     = "rg2-uswest"
  provider = azurerm.provider2-az-uswest # Here we have implemented multiple provider concept to create the rg in different region.
  location = "West US"

}