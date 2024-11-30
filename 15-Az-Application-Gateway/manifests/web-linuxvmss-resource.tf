# Resource VMSS(Virtual machine scale sets)

resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name                 = "${local.resource_name_prefix}-web-vmss"
  admin_username       = var.linux_admin_username
  computer_name_prefix = "vmss-web"
  location             = azurerm_resource_group.rg.location
  sku                  = "Standard_DS1_v2"
  resource_group_name  = azurerm_resource_group.rg.name

  instances = 2 # Manually defining the number of instances. Hence, it is called manual scaling

  upgrade_mode = "Automatic" # VMs will be auto upgraded after associated with LB

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
  network_interface {
    name                      = "vmss-nic"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.web_vmss_nsg.id

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.web_subnet.id
      # here the VMSS is now associated with LoadBalancer.
      #load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_backend_address_pool.id]

      # Intead of Load Balancer, we will now attach it to Application Gateway
      #application_gateway_backend_address_pool_ids = azurerm_application_gateway.web_application_gateway.
      application_gateway_backend_address_pool_ids = [for pool in azurerm_application_gateway.web_application_gateway.backend_address_pool : pool.id]    
    }

  }
  custom_data = filebase64("${path.module}/app-script/webvm.sh") # One way of passing custom script


}