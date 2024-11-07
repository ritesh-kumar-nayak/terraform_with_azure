# In some regions bastion azure native bastion service is not available or not conveinient to use. In those cases we can provision our own bastion host

# 1- Public IP for Linux Bastion Host VM
resource "azurerm_public_ip" "bastion_host_publicip" {
  name                = "${local.resource_name_prefix}-${var.linux_bastionhost_publicip}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# 2- Network Interface 
resource "azurerm_network_interface" "linux_bastionhost_NIC" {
  name                = "${local.resource_name_prefix}-${var.linux_bastionhost_nic_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "bastionhost_ip_1"
    subnet_id                     = azurerm_subnet.bastion_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_publicip.id
  }

}

# 3- Create Bastion Host Linux Virtual Machine

resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {

  name                            = "${local.resource_name_prefix}-${var.bastionhost_vm_name}"
  computer_name                   = var.bastionhost_vm_hostname
  admin_username                  = var.linux_admin_username
  size                            = var.vm_size
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.linux_bastionhost_NIC.id
  ]

  admin_ssh_key {
    username   = var.linux_admin_username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

}