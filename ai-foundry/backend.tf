terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "sastatevlab2026"
    container_name       = "ai-foundry"
    key                  = "ai-foundry/terraform.tfstate"
  }
}

