resource "azurerm_public_ip" "pip" {
  for_each            = var.linux_vms
  name                = "${each.key}-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [each.value]
  domain_name_label   = "vm-${each.key}"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.linux_vms
  name                = "${each.key}-nic"
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each              = var.linux_vms
  name                  = each.key
  computer_name         = each.key
  resource_group_name   = var.rg_name
  location              = var.location
  size                  = var.vm_size
  zone                  = each.value
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  tags                  = var.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2-gen2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_uri
  }
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each                   = var.linux_vms
  name                       = "NetworkWatcherAgentLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm[each.key].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
  tags                       = var.tags
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each                   = var.linux_vms
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm[each.key].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = var.tags
}
