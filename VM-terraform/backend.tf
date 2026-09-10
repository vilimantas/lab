terraform {
  # NOTE: backend blocks cannot reference variables, values must match the
  # bootstrap job in pipelines/vm-terraform-pipeline.yml and variables.tf defaults.
  backend "azurerm" {
      resource_group_name  = "tfstate-rg"
      storage_account_name = "sastatevlab2026"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }

}

