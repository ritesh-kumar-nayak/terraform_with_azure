business_unit           = "hr"
environment_dev         = "dev"
resource_group_name     = "rg-iaas-terraform"
resource_group_location = "eastus"


vnet_name = "az-vnet-default"

vnet_address_space = ["10.0.0.0/16"]

web_subnet_name    = "websubnet"
web_subnet_address = ["10.0.1.0/24"]

app_subnet_name    = "appsubnet"
app_subnet_address = ["10.0.11.0/24"]

db_subnet_name    = "dbsubnet"
db_subnet_address = ["10.0.21.0/24"]

bastion_subnet_name    = "bastionsubnet"
bastion_subnet_address = ["10.0.0.0/25"]