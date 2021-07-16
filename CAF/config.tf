module "globals" {
  source   = "../../config/global"
  for_each = toset(var.identity_settings.locations)

  applicationName = var.WORKSPACE
  environment     = var.ENVIRONMENT
  location        = each.key
}

module "environment" {
  source = "../../config/environment"
}
