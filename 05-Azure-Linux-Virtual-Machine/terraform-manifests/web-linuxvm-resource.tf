# Resource: Azure linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {

    name = "${local.resource_name_prefix}-${var.vm_name}"
    computer_name = var.host_name
    admin_username = var.linux_admin_username
    size = var.vm_size
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    disable_password_authentication = true

    network_interface_ids =[
        azurerm_network_interface.web_linuxvm_NIC.id
    ]

    admin_ssh_key {
      username = var.linux_admin_username
      public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
    }
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "RedHat"
      offer = "RHEL"
      sku = "83-gen2"
      version = "latest"
    }   

/* custom_data accepts only encoded sensitive content that should be base64 encoded. To achieve that we need to use filebase64() function. In this approach we can not refer to any resouce attribute inside the script. We can also use locals block with custom data which we'll be using in other advanced resource creations*/

    custom_data = filebase64("${path.module}/app-script/webvm.sh") # One way of passing custom script

}