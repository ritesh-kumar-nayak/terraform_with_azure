# Movoing the private ssh key is important as we are going to take connect from this bastion host vm to our actual workload vm in web tier
resource "null_resource" "null_copy_ssh_privatekey_to_bastionhost" {

  depends_on = [azurerm_linux_virtual_machine.bastion_host_linuxvm] # This resource block needs to be executed only after vm creation
  connection {
    host        = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    type        = "ssh"
    user        = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  provisioner "file" {
    source      = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
  }
  ## Remote Exec provisioner 
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-azure.pem"
    ]

  }

}