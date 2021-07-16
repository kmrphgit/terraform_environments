resource "azurerm_virtual_network" "vnet" {
  name                = "${var.settings.naming_conventions.vnet}-${var.settings.iteration}"
  location            = var.settings.location
  resource_group_name = var.rg_name
  address_space       = var.settings.vnet.address_space
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