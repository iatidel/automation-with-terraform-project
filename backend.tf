terraform {
  backend "azurerm" {
     resource_group_name = "tfstate8365RG"
     storage_account_name = "tfstate8365sa"
     container_name       = "tfstatefiles"
     key                  = "project-8365.tfstate"
  }
}
