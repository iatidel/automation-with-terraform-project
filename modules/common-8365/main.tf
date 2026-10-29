resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = var.vault_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}
