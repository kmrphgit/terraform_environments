module "subscriptions" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//subscription"

  depends_on = [module.globals, module.environment]

  settings = module.globals.sub_settings
}

# resource "null_resource" "login_ado_spn" {
#   depends_on = [module.subscriptions]
#   provisioner "local-exec" {
#     command = "az login --service-principal --username ${module.globals.spn.ado.client_id} --password ${module.globals.spn.ado.client_secret} --tenant ${module.globals.spn.ado.tenant_id}"
#   }
# }

module "identity" {
  source   = "./identity"
  for_each = toset(var.identity_settings.locations)

  depends_on = [null_resource.login_ado_spn]

  settings = merge(var.settings, module.globals.settings)
  # location           = module.globals.locations
  # naming_conventions = module.globals[each.key]

}

# module "management" {
#   source = "./management"
#   for_each = toset(var.management_settings.locations)

#   depends_on = [null_resource.login_ado_spn]

#   settings = var.management_settings
#   naming_conventions = module.globals[each.key].naming_conventions

# }
module "subscription" {
  source = "../"

}