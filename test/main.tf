locals {

  applicationName = {
    applicationName = var.applicationName
  }

  location = {
    location = var.location
  }

  naming_components = {
    component1 = var.applicationName
    component2 = var.environment
    component3 = local.location.location
  }
  naming_prefix = "${local.naming_components.component1}-${local.naming_components.component2}-${local.naming_components.component3}"
  naming_conventions = {
    naming_conventions = {
      resource_group = "rg-${local.naming_prefix}"
      vnet           = "vnet-${local.naming_prefix}"
      subnet         = "snet-${local.naming_prefix}-$${each.key}"
      log_analytics  = "lga-${local.naming_prefix}"
      nsg            = "nsg-${local.naming_prefix}"
    }
  }

  vnet_names = {
      for k, v in settings.networking.vnets : k => "{lookup(local.naming_conventions.naming_conventions.key)}
  }

  settings = merge(local.location, local.naming_conventions, local.applicationName)

#   sub_settings = {
#     billing_account_name = var.spn.billing_account_name
#     billing_profile_name = var.spn.billing_profile_name
#     invoice_section_name = (
#       contains(["identity", "management", "connectivity"], var.applicationName) && var.environment == "" ? var.spn.invoice_section_name.core : (
#         var.environment == "prod" && var.applicationName != null ? var.spn.invoice_section_name.prod : var.spn.invoice_section_name.nonprod
#       )
#     )
#     alias = var.applicationName
#     name  = "kloudmorph-${var.applicationName}"
#     workload = (
#       var.environment == "nonprod" ? "DevOps" : "Production"
#     )
#     subscription_name = "kloudmorph"
#   }

#   spn = {
#     subs = var.spn.subs
#     ado  = var.spn.ado
#     mg   = var.spn.mg
#   }
}
