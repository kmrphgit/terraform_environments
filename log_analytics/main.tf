resource "azurerm_log_analytics" "lga" {
  name     = "${var.settings.naming_conventions.log_analytics}-${var.iteration}"
  location = var.global_settings.regions[lookup(var.settings, "region", var.global_settings.default_region)]
  # tags = merge(
  #   var.tags,
  #   lookup(var.settings, "tags", {})
  # )
}