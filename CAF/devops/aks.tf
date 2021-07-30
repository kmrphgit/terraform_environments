module "aks" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//compute/aks"
  for_each = var.settings.aks_clusters

  rg_name   = module.rg[each.value.rg_key].rg_name
  iteration = each.key
  settings = merge(
    module.globals.settings,
    module.networking[each.vaule.vnet_key],
    module.acr[each.vaule.vnet_key],
    each.value
  )
  location = var.settings.location
}