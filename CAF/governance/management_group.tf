module "management_groups" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//management_group"

  depends_on = [module.environment]

  settings = merge(
    var.settings.mg_settings,
    #{mg_spn = var.settings.spn.mg}
  )
}
