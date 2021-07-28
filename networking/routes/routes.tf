resource "azurerm_route" "route" {
  name                   = var.settings.route_name
  resource_group_name    = var.rg_name
  route_table_name       = var.settings.route_table_name
  address_prefix         = var.settings.address_prefix
  next_hop_type          = var.settings.next_hop_type
  next_hop_in_ip_address = try(lower(var.settings.next_hop_type), null) == "virtualappliance" ? coalesce(var.settings.next_hop_in_ip_address, var.settings.next_hop_in_ip_address_fw, var.settings.next_hop_in_ip_address_vm) : null
}