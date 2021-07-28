resource "null_resource" "workspace" {
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "terraform workspace select ${var.settings.applicationName}"
  }
}

resource "null_resource" "login_subs_spn" {
  depends_on = [null_resource.workspace]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.subs.client_id)} --password ${module.globals[var.settings.location].spn.subs.client_secret} --tenant ${module.globals[var.settings.location].spn.subs.tenant_id}"
    command = "az login --service-principal --username ${(settings.spn.subs.client_id)} --password ${settings.spn.subs.client_secret} --tenant ${settings.spn.subs.tenant_id}"

  }
}

resource "null_resource" "login_ado_spn" {
  depends_on = [module.subscriptions]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "az login --service-principal --username ${(settings.spn.ado.client_id)} --password ${settings.spn.ado.client_secret} --tenant ${settings.spn.ado.tenant_id}"

  }
}

module "naming" {
  source   = "git::https://github.com/kmrphgit/terraform_global_config.git//global"
  settings = var.settings
}
