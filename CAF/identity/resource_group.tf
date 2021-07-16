module "rg" {
  source   = "../../../modules/resource_group"
  for_each = var.settings.resource_group

  rg_name  = var.naming_conventions.resource_group
  location = var.locations[each.key] #location = var.location
}