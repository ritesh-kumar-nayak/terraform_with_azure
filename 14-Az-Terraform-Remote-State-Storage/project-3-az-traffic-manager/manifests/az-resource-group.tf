resource "azurerm_resource_group" "rg" {

  location = var.resource_group_location
  # To make the resource group name unique for every demo we are adding random ids which will avoid caching related issue in azure.
  name = "tm-${local.resource_name_prefix}-${var.resource_group_name}-${random_string.random_name.id}"
  tags = local.common_tags

}