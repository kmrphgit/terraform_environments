module "networking" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//networking/vnet"
  for_each = var.settings.networking.vnets

  rg_name   = module.rg.rg_name
  iteration = each.key
  settings  = merge(module.globals.settings, each.value)
  location  = var.settings.location
  # rg_name  = "${var.settings.naming_conventions.resource_group}-${var.settings["eastus2"].resource_group[each.key].iteration}"
}