module "aks" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//compute/aks"
  for_each = var.settings.aks_clusters

  rg_name   = module.rg[each.value.rg_key].rg_name
  iteration = each.key
  settings = merge(
    module.globals.settings,
    module.networking[each.value.vnet_key],
    module.acr[each.value.vnet_key],
    each.value
  )
}

output "aks" {
  value = module.aks
}