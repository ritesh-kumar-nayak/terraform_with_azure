terraform {
  required_version = "~>1.5.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.3.0"
    }
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "4accce4f-9342-4b5d-bf6b-5456d8fa879d"

}