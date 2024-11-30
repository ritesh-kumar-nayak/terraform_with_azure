output "bastion_host_publicip" {
  value       = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
  description = "Output bastion host linux vm ip"

}