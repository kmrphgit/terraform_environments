module "networking" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//networking/vnet"
  for_each = var.settings["eastus2"].vnet

  rg_name  = module.rg.rg_name
  location = var.settings.location
}