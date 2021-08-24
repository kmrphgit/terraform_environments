module "devops_prod" {
  source     = "../"
  for_each   = var.devops_prod
  settings = merge(
    { spn = var.spn },
    each.value,
  )
}