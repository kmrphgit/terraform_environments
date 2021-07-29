module "governance" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//management_group"
  for_each = var.governance
  settings = merge(each.value, var.billing, var.spn.mg)
}


module "identity_nonprod" {
  source     = "./identity"
  for_each   = var.identity_nonprod
  depends_on = [module.governance]
  settings   = merge(each.value, var.billing, var.spn)
}

module "identity_prod" {
  source     = "./identity"
  for_each   = var.identity_prod
  depends_on = [module.governance]
  settings   = merge(each.value, var.billing, var.spn)
}

# module "devops_prod" {
#   source     = "./devops"
#   for_each   = var.devops_prod
#   depends_on = [module.governance]
#   settings   = merge(each.value, var.billing, var.spn)
# }