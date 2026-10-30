locals {
  humber_id = "8365"
  location  = "eastus"

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
  vnet_space   = ["10.0.0.0/16"]
  subnet_name  = "${local.humber_id}-SUBNET"
  subnet_space = ["10.0.0.0/24"]
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
  vm_size          = "Standard_D2as_v4"
  admin_username   = "n10038365"
  public_key_path  = "/home/n10038365/.ssh/id_rsa.pub"
  private_key_path = "/home/n10038365/.ssh/id_rsa"
  linux_vms = {
    "8365-u-vm1" = "1"
    "8365-u-vm2" = "2"
    "8365-u-vm3" = "3"
  }
}
