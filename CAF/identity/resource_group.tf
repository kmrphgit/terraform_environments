module "rg" {
  source     = "git::https://github.com/kmrphgit/terraform_modules.git//resource_group"
  depends_on = [null_resource.workspace]
  for_each   = try(var.settings.resource_group, {})

  iteration = each.key
  settings  = merge(module.globals.settings, each.value)
}