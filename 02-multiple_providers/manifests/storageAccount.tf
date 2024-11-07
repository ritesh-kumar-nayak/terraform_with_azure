resource "random_string" "storageaccName" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_storage_account" "azStorageAcc" {
  name                     = "storage${random_string.storageaccName.id}"
  resource_group_name      = azurerm_resource_group.rg2-west.name
  location                 = azurerm_resource_group.rg2-west.location
  account_tier             = "Standard"
  account_replication_type = "GRS"


}