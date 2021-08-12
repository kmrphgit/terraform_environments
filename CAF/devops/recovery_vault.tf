module "arv" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//recovery_vault"
  for_each = try(var.settings.recovery_vaults, {})

  settings = merge(
    { rg_name = module.rg[each.value.rg_key].rg_name },
    { location = var.settings.location },
    { iteration = each.key },
    module.globals.settings,
    module.networking[each.value.rg_key],
    each.value
  )
}