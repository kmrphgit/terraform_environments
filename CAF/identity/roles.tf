module "subscription_roles" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//roles/role_assignment"

  depends_on = [module.mg_associate]

  settings = merge(
    module.globals.settings,
    { sub_id = module.subscriptions.subscription_id },
    { rbac_spn = var.settings.spn.rbac },
    { keys = {
      "object_ids" = {
        "rbac" = {
          "principal_id"         = var.settings.spn.rbac.client_id
          #"scope"                = module.subscriptions.id
          "scope_type"                = "subscription"
          "role_definition_name" = "Contributor"
        }
      }
    } },
    { workspace = var.settings.applicationName }
  )
}
