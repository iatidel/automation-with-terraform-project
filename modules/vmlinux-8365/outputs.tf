output "vm_names" {
  value = { for k, v in azurerm_linux_virtual_machine.vm : k => v.name }
}

output "fqdns" {
  value = { for k, v in azurerm_public_ip.pip : k => v.fqdn }
}

output "private_ips" {
  value = { for k, v in azurerm_network_interface.nic : k => v.private_ip_address }
}

output "public_ips" {
  value = { for k, v in azurerm_public_ip.pip : k => v.ip_address }
}

output "vm_ids" {
  value = { for k, v in azurerm_linux_virtual_machine.vm : k => v.id }
}

output "nic_ids" {
  value = { for k, v in azurerm_network_interface.nic : k => v.id }
}

output "zones" {
  value = var.linux_vms
}
