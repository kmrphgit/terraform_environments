module "networking" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//networking/vnet"
  for_each = var.settings.vnet

  iteration = each.key
  rg_name   = module.rg["001"].rg_name
  settings  = var.settings
  # location = var.settings.location
  # rg_name  = "${var.settings.naming_conventions.resource_group}-${var.settings["eastus2"].resource_group[each.key].iteration}"
}