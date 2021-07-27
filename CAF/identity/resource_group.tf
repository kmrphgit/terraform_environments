module "rg" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//resource_group"
  depends_on = [module.workspace]
  for_each = var.settings.resource_group

  iteration = each.key
  settings  = var.settings
}