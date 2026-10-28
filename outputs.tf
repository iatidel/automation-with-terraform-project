output "resource_group_name" {
  value = module.rgroup.rg_name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}
