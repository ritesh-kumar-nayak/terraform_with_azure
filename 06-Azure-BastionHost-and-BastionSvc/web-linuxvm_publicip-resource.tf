# resource "azurerm_public_ip" "web_linuxvm_publicip" {

#     name = "${local.resource_name_prefix}-${var.web_linuxvm_publicip_name}"

#     allocation_method = var.allocation_type
#     location = azurerm_resource_group.rg.location
#     resource_group_name = azurerm_resource_group.rg.name

#     sku = var.sku_type
#     domain_name_label = "${var.domain_name}-${random_string.random_name.id}"

# }

/* The public IP resource is not necessary as this associated VM will be accessed via a bastion host and bastion service we dont need to expose the public ip of this machine */