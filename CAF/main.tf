module "governance" {
  source   = "./governance"
  for_each = var.governance
  settings = merge(
    each.value,
    { mg_spn = var.spn.mg }
  )
}

module "identity_nonprod" {
  source     = "./identity"
  for_each   = var.identity_nonprod
  depends_on = [module.governance]
  settings = merge(
    { spn = var.spn },
    each.value,
    var.billing,
  )
}

module "identity_prod" {
  source     = "./identity"
  for_each   = var.identity_prod
  depends_on = [module.governance]
  settings = merge(
    { spn = var.spn },
    each.value,
    var.billing,
  )
}

module "devops_prod" {
  source     = "./devops"
  for_each   = var.devops_prod
  depends_on = [module.governance]
  settings = merge(
    { spn = var.spn },
    each.value,
    var.billing,
  )
}