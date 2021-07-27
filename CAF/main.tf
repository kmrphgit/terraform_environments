resource "null_resource" "mg_workspace" {
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "terraform workspace select management"
  }
}

resource "null_resource" "login_mg_spn" {
  depends_on = [null_resource.mg_workspace]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "az login --service-principal --username ${(local.settings.spn.mg.client_id)} --password ${local.settings.spn.mg.client_secret} --tenant ${local.settings.spn.mg.tenant_id}"
  }
}

module "management_groups" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//management_group"

  depends_on = [module.globals, module.environment, null_resource.login_mg_spn]

  settings = var.mg_settings

}

resource "null_resource" "login_subs_spn" {
  depends_on = [module.management_groups]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.subs.client_id)} --password ${module.globals[var.settings.location].spn.subs.client_secret} --tenant ${module.globals[var.settings.location].spn.subs.tenant_id}"
    command = "az login --service-principal --username ${(local.settings.spn.subs.client_id)} --password ${local.settings.spn.subs.client_secret} --tenant ${local.settings.spn.subs.tenant_id}"

  }
}


module "subscriptions" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//subscription"

  depends_on = [null_resource.login_subs_spn]
  # depends_on = [module.globals, module.environment]

  settings = module.globals.sub_settings
}

resource "null_resource" "login_ado_spn" {
  depends_on = [module.subscriptions]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "az login --service-principal --username ${(local.settings.spn.ado.client_id)} --password ${local.settings.spn.ado.client_secret} --tenant ${local.settings.spn.ado.tenant_id}"

  }
}

# module "identity" {
#   source = "./identity"

#   depends_on = [null_resource.login_ado_spn]

#   settings = local.settings
#   # location           = module.globals.locations
#   # naming_conventions = module.globals[each.key]

# }

# module "management" {
#   source   = "./management"
#   for_each = toset(var.management_settings.locations)

#   depends_on = [null_resource.login_ado_spn]

#   settings           = var.management_settings
#   naming_conventions = module.globals[each.key].naming_conventions

# }