module "rg" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//resource_group"
  for_each = var.settings.resource_group

  rg_name  = var.settings.naming_conventions.resource_group
  location = each.key #location = var.location
}