terraform {
  required_version = "~>1.5.6" # Minor version upgrades are allowed
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">=3.6.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "terraformstatestore0"
    resource_group_name = "terraform-storageAcc-rg"
    container_name = "tfstatefiles"
    key = "project-2-westus2-terraform.tfstate"
    subscription_id = "4accce4f-9342-4b5d-bf6b-5456d8fa879d"
    
  }

}


provider "azurerm" {
  features {}
  subscription_id = "4accce4f-9342-4b5d-bf6b-5456d8fa879d"
}