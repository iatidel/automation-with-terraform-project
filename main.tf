locals {
  humber_id = "8365"
  location  = "canadacentral"

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
