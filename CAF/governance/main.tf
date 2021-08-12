module "globals" {
  source          = "git::https://github.com/kmrphgit/terraform_global_configs.git//global"
  applicationName = var.settings.applicationName
  environment     = var.settings.environment
  location        = var.settings.location
  settings        = var.settings
}

module "environment" {
  source = "git::https://github.com/kmrphgit/terraform_global_configs.git//environment"
}