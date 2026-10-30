resource "azurerm_availability_set" "avs" {
  name                         = var.avset_name
  resource_group_name          = var.rg_name
  location                     = var.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = var.tags
}

resource "azurerm_public_ip" "pip" {
  count               = var.nb_count
  name                = "${var.windows_name}${count.index + 1}-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "vm-${var.windows_name}${count.index + 1}"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  count               = var.nb_count
  name                = "${var.windows_name}${count.index + 1}-nic"
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "${var.windows_name}${count.index + 1}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  count                 = var.nb_count
  name                  = "${var.windows_name}${count.index + 1}"
  computer_name         = "${var.windows_name}${count.index + 1}"
  resource_group_name   = var.rg_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.windows_admin_user
  admin_password        = var.windows_admin_password
  availability_set_id   = azurerm_availability_set.avs.id
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  tags                  = var.tags

  winrm_listener {
    protocol = "Http"
  }

  os_disk {
    name                 = "${var.windows_name}${count.index + 1}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "windowsserver2022"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_uri
  }
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                      = var.nb_count
  name                       = "IaaSAntimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true
  tags                       = var.tags

  depends_on = [azurerm_windows_virtual_machine.vm]
}
