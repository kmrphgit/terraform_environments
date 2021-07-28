resource "null_resource" "workspace" {
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "terraform workspace select identity"
  }
}

module "globals" {
  source          = "git::https://github.com/kmrphgit/terraform_global_configs.git//global"
  depends_on      = [null_resource.workspace]
  applicationName = var.WORKSPACE
  environment     = var.ENVIRONMENT
  location        = var.settings.location
  # spn             = var.settings.spn
}

module "environment" {
  source     = "git::https://github.com/kmrphgit/terraform_global_configs.git//environment"
  depends_on = [null_resource.workspace]
}


resource "null_resource" "login_subs_spn" {
  depends_on = [module.environment]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.subs.client_id)} --password ${module.globals[var.settings.location].spn.subs.client_secret} --tenant ${module.globals[var.settings.location].spn.subs.tenant_id}"
    command = "az login --service-principal --username ${(var.settings.spn.subs.client_id)} --password ${var.settings.spn.subs.client_secret} --tenant ${var.settings.spn.subs.tenant_id}"

  }
}

resource "null_resource" "login_ado_spn" {
  depends_on = [module.subscriptions]
  provisioner "local-exec" {
    # command = "az login --service-principal --username ${(module.globals[element(keys(module.globals), 0)].spn.ado.client_id)} --password ${module.globals[var.settings.location].spn.ado.client_secret} --tenant ${module.globals[var.settings.location].spn.ado.tenant_id}"
    command = "az login --service-principal --username ${(var.settings.spn.ado.client_id)} --password ${var.settings.spn.ado.client_secret} --tenant ${var.settings.spn.ado.tenant_id}"

  }
}