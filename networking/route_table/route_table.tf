resource "azurerm_route_table" "rt" {
  name                          = "${var.settings.naming_conventions.route_table}-${var.iteration}"
  resource_group_name           = var.rg_name
  location                      = var.settings.location
  disable_bgp_route_propagation = var.settings.disable_bgp_route_propagation
}