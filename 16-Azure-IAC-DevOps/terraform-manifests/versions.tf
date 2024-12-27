terraform {
  required_version = ">=1.5.6" # Minor version upgrades are allowed
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
  # Nothing should be configured here in backend block as the detils will be passed via Azure DevOps pipeline
  backend "azurerm" {
    
  }

}

provider "azurerm" {
  features {}
  subscription_id = "4accce4f-9342-4b5d-bf6b-5456d8fa879d"
}
