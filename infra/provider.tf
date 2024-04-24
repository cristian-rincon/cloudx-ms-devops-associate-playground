terraform {
  required_providers {
    azurerm = {
      version = "3.100.0"
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      recover_soft_deleted_key_vaults = true
    }
  }
  use_cli = true
}