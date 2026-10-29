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
