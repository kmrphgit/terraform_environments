resource "azurerm_route_table" "rt" {
  name                          = var.settings.name
  resource_group_name           = var.settings.rg_name
  location                      = var.settings.location
  disable_bgp_route_propagation = var.settings.disable_bgp_route_propagation
  tags                          = local.tags
}