module "globals" {
  source   = "git::https://github.com/kmrphgit/terraform_global_config.git//global"
  for_each = var.settings

  applicationName = var.WORKSPACE
  environment     = var.ENVIRONMENT
  location        = each.key
  spn = var.spn
}

module "environment" {
  source = "git::https://github.com/kmrphgit/terraform_global_config.git//environment"
}
