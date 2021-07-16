resource "azurerm_resource_group" "rg" {
  name     = "${var.settings.naming_conventions.resource_group}-${var.iteration}"
  location = var.settings.location
  # tags = merge(
  #   var.tags,
  #   lookup(var.settings, "tags", {})
  # )
}