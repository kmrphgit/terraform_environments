module "acr" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//compute/acr"
  for_each = var.settings.azure_container_registries

  rg_name   = module.rg[each.value.rg_key].rg_name
  iteration = each.key
  settings  = merge(
    module.globals.settings,
    module.networking[each.value.vnet_key],
    module.private_dns, each.value
  )
}

output "acr" {
  value = module.acr
}