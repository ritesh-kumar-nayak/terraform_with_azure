locals {
  owners               = var.business_unit
  environment          = var.environment_dev
  resource_name_prefix = "${var.business_unit}-${var.environment_dev}"

  common_tags = {
    owners      = local.owners,
    environment = local.environment
  }

}