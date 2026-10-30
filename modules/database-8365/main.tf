resource "azurerm_postgresql_flexible_server" "db" {
  name                   = var.db_name
  resource_group_name    = var.rg_name
  location               = var.location
  version                = var.db_version
  sku_name               = var.db_sku
  storage_mb             = var.db_storage_mb
  administrator_login    = var.db_admin_user
  administrator_password = var.db_admin_password
  tags                   = var.tags
}
