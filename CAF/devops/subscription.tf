module "subscriptions" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//subscription"

  depends_on = [module.environment, module.globals]

  settings = merge(
    module.globals.sub_settings,
    module.globals.settings,
    { subs_spn = var.settings.spn.subs }
  )
}

output "subscriptions" {
  value = module.subscriptions
}