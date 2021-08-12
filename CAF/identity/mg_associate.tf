module "mg_associate" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//management_group/association"

  depends_on = [module.subscriptions]

  settings = merge(
    { mg_name = var.settings.environment },
    { sub_id = module.subscriptions.subscription_id },
    { mg_spn = var.settings.spn.mg },
    { workspace = "management" }

  )
}
