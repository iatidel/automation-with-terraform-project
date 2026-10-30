locals {
  humber_id = var.humber_id
  location  = var.location

  common_tags = {
    Project        = "CCGC 5502 Terraform Project"
    Name           = "iatidel.akik"
    ExpirationDate = "2027-12-31"
    Environment    = "Learning"
  }
}

module "rgroup" {
  source   = "./modules/rgroup-8365"
  rg_name  = "${local.humber_id}-RG"
  location = local.location
  tags     = local.common_tags
}

module "network" {
  source       = "./modules/network-8365"
  rg_name      = module.rgroup.rg_name
  location     = local.location
  tags         = local.common_tags
  vnet_name    = "${local.humber_id}-VNET"
  vnet_space   = var.vnet_space
  subnet_name  = "${local.humber_id}-SUBNET"
  subnet_space = var.subnet_space
  nsg_name     = "${local.humber_id}-NSG"
}

module "common" {
  source       = "./modules/common-8365"
  rg_name      = module.rgroup.rg_name
  location     = local.location
  tags         = local.common_tags
  law_name     = "${local.humber_id}-law"
  vault_name   = "rsv-${local.humber_id}"
  storage_name = "${local.humber_id}storage"
}

module "vmlinux" {
  source           = "./modules/vmlinux-8365"
  rg_name          = module.rgroup.rg_name
  location         = local.location
  tags             = local.common_tags
  subnet_id        = module.network.subnet_id
  storage_uri      = module.common.storage_uri
  vm_size          = var.linux_vm_size
  admin_username   = var.admin_username
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  linux_vms        = var.linux_vms
}

module "vmwindows" {
  source       = "./modules/vmwindows-8365"
  rg_name      = module.rgroup.rg_name
  location     = local.location
  tags         = local.common_tags
  subnet_id    = module.network.subnet_id
  storage_uri  = module.common.storage_uri
  vm_size      = var.windows_vm_size
  windows_name = "${local.humber_id}-w-vm"
  avset_name   = "${local.humber_id}-w-avset"
  nb_count     = var.windows_count
}

module "datadisk" {
  source         = "./modules/datadisk-8365"
  rg_name        = module.rgroup.rg_name
  location       = local.location
  tags           = local.common_tags
  linux_vm_ids   = module.vmlinux.vm_ids
  linux_zones    = module.vmlinux.zones
  windows_vm_ids = module.vmwindows.vm_ids
  windows_names  = module.vmwindows.hostnames
  disk_size      = var.disk_size
}

module "loadbalancer" {
  source   = "./modules/loadbalancer-8365"
  rg_name  = module.rgroup.rg_name
  location = local.location
  tags     = local.common_tags
  lb_name  = "${local.humber_id}-LB"
  lb_sku   = var.lb_sku
  nic_ids  = module.vmlinux.nic_ids
}

module "database" {
  source        = "./modules/database-8365"
  rg_name       = module.rgroup.rg_name
  location      = var.db_location
  tags          = local.common_tags
  db_name       = "${local.humber_id}-psql"
  db_version    = var.db_version
  db_sku        = var.db_sku
  db_storage_mb = var.db_storage_mb
}
