output "resource_group_name" {
  value = module.rgroup.rg_name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "law_name" {
  value = module.common.law_name
}

output "vault_name" {
  value = module.common.vault_name
}

output "storage_name" {
  value = module.common.storage_name
}
