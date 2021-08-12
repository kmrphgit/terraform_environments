module "globals" {
  source = "git::https://github.com/kmrphgit/terraform_global_configs.git//global"
  applicationName = var.settings.applicationName
  environment     = var.settings.environment
  location        = var.settings.location
  settings        = var.settings
}

module "environment" {
  source = "git::https://github.com/kmrphgit/terraform_global_configs.git//environment"
}

resource "null_resource" "login_ado_spn" {
  depends_on = [module.subscription_roles]
  provisioner "local-exec" {
    command = "az login --service-principal --username ${(var.settings.spn.ado.client_id)} --password ${var.settings.spn.ado.client_secret} --tenant ${var.settings.spn.ado.tenant_id}"

  }
}