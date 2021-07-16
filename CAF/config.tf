module "globals" {
  source   = "git::https://github.com/kmrphgit/terraform_global_config.git//global"

  applicationName = var.WORKSPACE
  environment     = var.ENVIRONMENT
  location        = var.settings.location
  spn             = var.spn
}

module "environment" {
  source = "git::https://github.com/kmrphgit/terraform_global_config.git//environment"
}
