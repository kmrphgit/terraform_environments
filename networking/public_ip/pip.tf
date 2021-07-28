resource "azurerm_public_ip" "pip" {
  name                    = "${var.settings.naming_conventions.public_ip}-${var.settings.iteration}"
  resource_group_name     = var.settings.resource_group_name
  location                = var.settings.location
  allocation_method       = var.settings.allocation_method
  sku                     = var.settings.sku
  ip_version              = var.settings.ip_version
  idle_timeout_in_minutes = var.settings.idle_timeout_in_minutes
  domain_name_label       = var.settings.generate_domain_name_label ? self.name : var.settings.domain_name_label
  reverse_fqdn            = var.settings.reverse_fqdn
  availability_zone       = var.settings.zones
  # tags                    = local.tags
  public_ip_prefix_id = var.settings.public_ip_prefix_id
  #  ip_tags                 = var.settings.ip_tags
}