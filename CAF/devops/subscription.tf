module "subscriptions" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//subscription"

  depends_on = [null_resource.login_subs_spn]
  # depends_on = [module.globals, module.environment]

  settings = module.globals.sub_settings
}
