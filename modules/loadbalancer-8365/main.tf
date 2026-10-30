resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.lb_name}-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = var.lb_sku
  tags                = var.tags
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.lb_sku
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  name            = "backend-pool"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "probe" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool.id]
  probe_id                       = azurerm_lb_probe.probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "assoc" {
  for_each                = var.nic_ids
  network_interface_id    = each.value
  ip_configuration_name   = "${each.key}-ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool.id
}

