locals {
  disks = merge(
    { for k, id in var.linux_vm_ids : k => { vm_id = id, zone = var.linux_zones[k] } },
    { for i, id in var.windows_vm_ids : var.windows_names[i] => { vm_id = id, zone = null } }
  )
}

resource "azurerm_managed_disk" "disk" {
  for_each             = local.disks
  name                 = "${each.key}-data-disk"
  resource_group_name  = var.rg_name
  location             = var.location
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size
  zone                 = each.value.zone
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach" {
  for_each           = local.disks
  managed_disk_id    = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id = each.value.vm_id
  lun                = 0
  caching            = "ReadWrite"
}
