module "networking" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//networking/vnet"
  for_each = var.settings["eastus2"].resource_group

  rg_name  = "${var.settings.naming_conventions.resource_group}-${var.settings["eastus2"].resource_group[each.key].iteration}"
  location = var.settings.location
}