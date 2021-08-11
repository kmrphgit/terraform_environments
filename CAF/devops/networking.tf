module "networking" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//networking/vnet"
  for_each = var.settings.networking.vnets

  rg_name   = module.rg[each.value.rg_key].rg_name
  iteration = each.key
  settings = merge(
    module.globals.settings,
    each.value
  )
}

output "networking" {
  value = module.networking
}


  