resource "azurerm_subnet" "subnet" {

  name                                           = var.settings.name
  resource_group_name                            = var.settings.rg_name
  virtual_network_name                           = var.settings.vnet_name
  address_prefixes                               = var.settings.address_prefixes
  service_endpoints                              = var.settings.service_endpoints
  enforce_private_link_endpoint_network_policies = try(var.settings.enforce_private_link_endpoint_network_policies, false)
  enforce_private_link_service_network_policies  = try(var.settings.enforce_private_link_service_network_policies, false)

  dynamic "delegation" {
    for_each = try(var.settings.delegation, null) == null ? [] : [1]

    content {
      name = var.settings.delegation.name

      service_delegation {
        name    = var.settings.delegation.service_delegation
        actions = lookup(var.settings.delegation, "actions", null)
      }
    }
  }

}