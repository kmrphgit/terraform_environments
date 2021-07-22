locals {
  nic_ids = flatten(
    [
      for nic_key in var.settings.virtual_machine_settings[var.settings.os_type].network_interface_keys : [
        azurerm_network_interface.nic[nic_key].id
      ]
    ]
  )
}

resource "azurerm_network_interface" "nic" {
  for_each = var.settings.networking_interfaces

  name                = azurecaf_name.nic[each.key].result
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_servers                   = lookup(each.value, "dns_servers", null)
  enable_ip_forwarding          = lookup(each.value, "enable_ip_forwarding", false)
  enable_accelerated_networking = lookup(each.value, "enable_accelerated_networking", false)
  internal_dns_name_label       = lookup(each.value, "internal_dns_name_label", null)
  tags                          = merge(local.tags, try(each.value.tags, null))

  ip_configuration {
    name                          = azurecaf_name.nic[each.key].result
    subnet_id                     = try(each.value.subnet_id, try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id))
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
    private_ip_address_version    = lookup(each.value, "private_ip_address_version", null)
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    primary                       = lookup(each.value, "primary", null)
    public_ip_address_id          = try(each.value.public_address_id, lookup(each.value, "public_ip_address_key", null) == null ? null : try(var.public_ip_addresses[var.client_config.landingzone_key][each.value.public_ip_address_key].id, var.public_ip_addresses[each.value.lz_key][each.value.public_ip_address_key].id))
  }

  dynamic "ip_configuration" {
    for_each = try(each.value.ip_configurations, {})

    content {
      name                          = ip_configuration.value.name
      subnet_id                     = try(each.value.subnet_id, null) != null ? each.value.subnet_id : try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, "Dynamic")
      private_ip_address_version    = lookup(ip_configuration.value, "private_ip_address_version", null)
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      primary                       = lookup(ip_configuration.value, "primary", null)
      public_ip_address_id          = try(each.value.public_address_id, lookup(each.value, "public_ip_address_key", null) == null ? null : try(var.public_ip_addresses[var.client_config.landingzone_key][each.value.public_ip_address_key].id, var.public_ip_addresses[each.value.lz_key][each.value.public_ip_address_key].id))
    }
  }
}