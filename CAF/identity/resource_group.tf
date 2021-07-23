module "rg" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//resource_group"
  for_each = var.settings.resource_group

  iteration = each.key
  settings  = var.settings
}