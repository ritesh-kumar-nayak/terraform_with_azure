output "web_ag_id" {
  value = azurerm_application_gateway.web_application_gateway.id

}
output "web_ag_public_ip" {
  value       = azurerm_public_ip.web_application_gateway_publicip.ip_address
  description = "Public IP of application Gateway"
}