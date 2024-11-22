output "web_lb_public_ip" {
  value       = azurerm_public_ip.lb_web_publicip.ip_address
  description = "Public ip of load balancer"

}

output "web_lb_public_ip_id" {
  value       = azurerm_public_ip.lb_web_publicip.id
  description = "Public ip of load balancer"

}

output "web_lb_id" {
  value       = azurerm_lb.lb_web.id
  description = "Load Balancer Id"

}
output "web_lb_frontend_ip_configuration" {
  value       = [azurerm_lb.lb_web.frontend_ip_configuration]
  description = "Web LB Frontend IP configuration"

}