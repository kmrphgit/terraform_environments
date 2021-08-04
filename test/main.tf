provider "azurerm" {
  features {}
}


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


  settings = merge(local.location, local.naming_conventions, local.applicationName)
  # flatten_naming_conventions = flatten(local.naming_conventions)

  # network_subnets = flatten([
  #   for network_key, network in var.networks : [
  #     for subnet_key, subnet in network.subnets : {
  #       network_key = network_key
  #       subnet_key  = subnet_key
  #       network_id  = aws_vpc.example[network_key].id
  #       cidr_block  = subnet.cidr_block
  #     }
  #   ]
  # ])

  # subnets = for_each = {

  # }

}

module "globals" {
  source = "git::https://github.com/kmrphgit/terraform_global_configs.git//global"
  # applicationName = var.WORKSPACE
  # environment     = var.ENVIRONMENT
  applicationName = "devops"
  environment     = "eastus2"
  location        = var.settings.location
  settings        = merge(var.settings, var.spn, var.billing)

}


# module "networking" {
#   source   = "git::https://github.com/kmrphgit/terraform_modules.git//networking/vnet"
#   for_each = var.settings.networking.vnets
#   depends_on = [
#     module.globals
#   ]

#   rg_name   = "rg_name"
#   iteration = each.key
#   settings  = merge(module.globals.settings, each.value)
# }

# output "networking" {
#   value = module.networking
# }

module "mssql_server" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//databases/mssql_server"
  for_each = var.settings.mssql_server
  # iteration = each.key
  settings = merge(
    { location = var.settings.location },
    { iteration = each.key },
    { rg_name = "rg_name" },
    each.value
  )
}

output "mssql_server" {
  value = module.mssql_server
}

module "mssql_database" {
  source   = "git::https://github.com/kmrphgit/terraform_modules.git//databases/mssql_database"
  for_each = var.settings.mssql_database
  # iteration = each.key
  settings = merge(
    { server_id = module.mssql_server[each.value.server_key].id },
    { iteration = each.key },
    each.value
  )
}

output "mssql_database" {
  value = module.mssql_database
}