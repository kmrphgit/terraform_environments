resource "azurerm_log_analytics" "lga" {
  count    = var.lga_name
  name     = var.rg_name
  location = var.global_settings.regions[lookup(var.settings, "region", var.global_settings.default_region)]
  # tags = merge(
  #   var.tags,
  #   lookup(var.settings, "tags", {})
  # )
}