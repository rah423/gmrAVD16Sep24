terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.1, < 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
    # azapi = {
    #   source  = "Azure/azapi"
    #   version = ">= 1.4.0, < 2.0" #"~> 1.13"
    # }
  }
  backend "azurerm" {
    resource_group_name   = "AVD-RG"
    storage_account_name  = "rgmtfstatestorageaccount"
    container_name        = "gmrtfsate"
    key                   = "avd.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy          = true
      purge_soft_deleted_keys_on_destroy    = true
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_key_vaults       = true
      recover_soft_deleted_keys             = true
      recover_soft_deleted_secrets          = true
    }
  }
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  tenant_id       = var.TENANT_ID
  subscription_id = var.SUBSCRIPTION_ID
}

