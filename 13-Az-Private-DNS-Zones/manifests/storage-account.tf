resource "azurerm_storage_account" "storage_account_lb" {
  name                     = "${var.storage_account_name}${random_string.random_name.id}"
  account_replication_type = var.storage_account_replication_type
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  access_tier              = var.storage_account_access_tier
  account_kind             = var.storage_account_kind
  account_tier             = var.storage_account_tier

  static_website {
    index_document     = var.static_websit_index_document
    error_404_document = var.static_website_error_404_document
  }

}

resource "azurerm_storage_container" "storage_container" {
  name                  = "${local.resource_name_prefix}-httpd-files-container"
  storage_account_name  = azurerm_storage_account.storage_account_lb.name
  container_access_type = "private"

}

# Resource to upload file to the container
/*resource "azurerm_storage_blob" "storage_container_blob" {
  for_each               = toset(var.httpd_files)
  name                   = "upload_${each.value}_file"
  storage_account_name   = azurerm_storage_account.storage_account_lb.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
  source                 = "${path.module}/app-scripts/${each.value}"

}*/
resource "azurerm_storage_blob" "storage_container_blob" {
  for_each              = toset(var.httpd_files)
  name                  = "upload_${each.value}_file"
  storage_account_name  = azurerm_storage_account.storage_account_lb.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                  = "Block"
  source                = "${path.module}/app-script/${each.value}"
}
