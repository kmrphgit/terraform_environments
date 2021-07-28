resource "azurerm_virtual_network" "vnet" {
  name                = "${var.settings.naming_conventions.vnet}-${var.iteration}"
  location            = var.settings.location
  resource_group_name = var.rg_name
  address_space       = var.settings.vnet[var.iteration].address_space
  #   tags                = local.tags

  #   dns_servers = lookup(var.settings.vnet, "dns_servers", null)

  #   dynamic "ddos_protection_plan" {
  #     for_each = var.ddos_id != "" ? [1] : []

  #     content {
  #       id     = var.ddos_id
  #       enable = true
  #     }
  #   }
}

module "special_subnets" {
  source = "./subnet"

  for_each = lookup(var.settings, "specialsubnets", {})
  # name                                           = each.value.name
  # global_settings                                = var.global_settings
  rg_name   = azurerm_virtual_network.vnet.resource_group_name
  vnet_name = azurerm_virtual_network.vnet.name
  # address_prefixes                               = lookup(each.value, "cidr", [])
  # service_endpoints                              = lookup(each.value, "service_endpoints", [])
  # enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)
  # enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)
  settings = merge({ name = "${var.settings.naming_conventions.subnet}-${each.key}" }, each.value)
}

module "subnets" {
  source = "./subnet"

  for_each = lookup(var.settings, "subnets", {})
  # name                                           = each.value.name
  # global_settings                                = var.global_settings
  rg_name   = vazurerm_virtual_network.vnet.resource_group_name
  vnet_name = azurerm_virtual_network.vnet.name
  # address_prefixes                               = lookup(each.value, "cidr", [])
  # service_endpoints                              = lookup(each.value, "service_endpoints", [])
  # enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)
  # enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)
  settings = merge({ name = "${var.settings.naming_conventions.subnet}-${each.key}" }, each.value)
}