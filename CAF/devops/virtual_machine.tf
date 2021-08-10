module "virtual_machines" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//compute/virtual_machine"
  for_each = var.settings.virtual_machines

  rg_name   = module.rg[each.value.rg_key].rg_name
  iteration = each.key
  settings = merge(
    module.globals.settings,
    module.networking[each.value.vnet_key],
    module.arv[each.value.arv_key],
    {keyvaults = var.settings.keyvaults},
    {keyvault_keys = var.settings.keyvault_keys},
    {disk_encryption_sets = var.settings.disk_encryption_sets},
    each.value
  )
}

output "virtual_machines" {
  value = module.virtual_machines
}