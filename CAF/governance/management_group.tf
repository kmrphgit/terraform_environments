module "management_groups" {
  source = "git::https://github.com/kmrphgit/terraform_modules.git//management_group"

  depends_on = [null_resource.login_mg_spn]
  for_each   = var.settings.mg_settings
  settings   = each.value

}
