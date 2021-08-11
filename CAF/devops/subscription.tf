module "subscriptions" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//subscription"

  depends_on = [null_resource.login_subs_spn]
  # depends_on = [module.globals, module.environment]

  settings = merge(
    module.globals.sub_settings,
    {subs = var.settings.spn.subs}
  )
}

output "subscriptions" {
  value = module.subscriptions
}