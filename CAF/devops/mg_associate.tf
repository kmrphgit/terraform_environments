module "mg_associate" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//management_group/association"

  depends_on = [module.subscriptions]
  
  settings = merge(
    {mg_name = var.environment},
    {sub_id = module.subscriptions.subscription_id},
    {rbac = var.settings.spn.rbac},
    {workspace = "management"}

  )  
}
