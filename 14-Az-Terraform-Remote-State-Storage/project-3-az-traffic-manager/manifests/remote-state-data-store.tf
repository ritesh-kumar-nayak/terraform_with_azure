# Project-1 Datasource(EASTUS2)
data "terraform_remote_state" "project1_eastus" {
    backend = "azurerm"
    config = {
        storage_account_name = "terraformstatestore0"
        resource_group_name = "terraform-storageAcc-rg"
        container_name = "tfstatefiles"
        key = "project-1-eastus2-terraform.tfstate"
        subscription_id = "4accce4f-9342-4b5d-bf6b-5456d8fa879d"
    }
  
}

# Project-2 Datasource(WESTUS)
data "terraform_remote_state" "project2_westus" {
    backend = "azurerm"
    config = {
        storage_account_name = "terraformstatestore0"
        resource_group_name = "terraform-storageAcc-rg"
        container_name = "tfstatefiles"
        key = "project-2-westus2-terraform.tfstate"
        subscription_id = "4accce4f-9342-4b5d-bf6b-5456d8fa879d"
    }
  
}