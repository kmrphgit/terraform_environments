module "rg" {
  source     = "git::https://github.com/kmrphgit/terraform_modules.git//resource_group"
  depends_on = [null_resource.workspace]
  for_each   = var.settings.resource_group

  iteration = each.key
  location = var.settings.location
  settings  = merge(module.globals.settings, each.value)
}