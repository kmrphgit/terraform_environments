module "management_groups" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//management_group"

  depends_on = [module.globals, module.environment]

  settings = var.mg_settings

}

module "subscriptions" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//subscription"

  depends_on = [module.management_groups]
  # depends_on = [module.globals, module.environment]

  settings = module.globals["eastus2"].sub_settings
}

resource "null_resource" "login_ado_spn" {
  depends_on = [module.subscriptions]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "az login --service-principal --username ${(module.globals[var.settings.location].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"

  }
}

module "identity" {
  source   = "./identity"
  for_each = var.settings

  depends_on = [null_resource.login_ado_spn]

  settings = merge(var.settings, module.globals["eastus2"].settings)
  # location           = module.globals.locations
  # naming_conventions = module.globals[each.key]

}

# module "management" {
#   source = "./management"
#   for_each = toset(var.management_settings.locations)

#   depends_on = [null_resource.login_ado_spn]

#   settings = var.management_settings
#   naming_conventions = module.globals[each.key].naming_conventions

# }