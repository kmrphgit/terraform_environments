module "private_dns" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//networking/private-dns"
  for_each = var.settings.networking.vnets

  rg_name   = module.rg[each.value.rg_key].rg_name
  iteration = each.key
  settings  = merge(module.globals.settings, module.networking, each.value)
  location  = var.settings.location
}

output "private_dns" {
  value = module.prviate_dns
}