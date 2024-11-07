terraform {
  required_version = "~>1.5.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "4accce4f-9342-4b5d-bf6b-5456d8fa879d"

}

provider "azurerm" {
  alias = "provider2-az-uswest"
  # These additional settings mentioned in the features block will be applied to the resoures provisioned using this particula provider.
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
  # subscription_id = "" we can also define different subscription_id explicitly for this provider
  subscription_id = "4accce4f-9342-4b5d-bf6b-5456d8fa879d"
}