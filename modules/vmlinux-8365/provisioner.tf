resource "terraform_data" "hostnames" {
  for_each = var.linux_vms

  depends_on = [
    azurerm_linux_virtual_machine.vm,
    azurerm_virtual_machine_extension.network_watcher,
    azurerm_virtual_machine_extension.azure_monitor
  ]

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.pip[each.key].ip_address
    user        = var.admin_username
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = ["hostname"]
  }
}
