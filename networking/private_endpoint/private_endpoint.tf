resource "azurerm_private_endpoint" "pep" {
  name                = "${var.settings.naming_conventions.private_endpoint}-${var.iteration}"
  location            = var.settings.location
  resource_group_name = var.settings.rg_name
  subnet_id           = var.settings.subnet_id
  #  tags                = local.tags

  private_service_connection {
    name                           = var.settings.private_service_connection.name
    private_connection_resource_id = var.settings.resource_id
    is_manual_connection           = try(var.settings.private_service_connection.is_manual_connection, false)
    subresource_names              = var.settings.private_service_connection.subresource_names
    request_message                = try(var.settings.private_service_connection.request_message, null)
  }

  dynamic "private_dns_zone_group" {
    for_each = try(var.settings.private_dns, {}) == {} ? [] : [1]

    content {
      name                 = var.settings.private_dns.zone_group_name
      private_dns_zone_ids = local.private_dns_zone_ids
    }
  }
}
