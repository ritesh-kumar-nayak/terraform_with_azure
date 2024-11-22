output "traffic_manager_fqdn" {
    description = "Traffic manager FQDN"
    value = azurerm_traffic_manager_profile.tm_profile.fqdn
  
}