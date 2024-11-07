output "storage_account_primary_access_key" {
  value     = azurerm_storage_account.storage_account_lb.primary_access_key
  sensitive = true

}
output "storage_account_primary_web_endpoint" {
  value = azurerm_storage_account.storage_account_lb.primary_web_endpoint

}
output "storage_account_primary_web_host" {
  value = azurerm_storage_account.storage_account_lb.primary_web_host

}
output "storage_account_name" {
  value = azurerm_storage_account.storage_account_lb.name

}