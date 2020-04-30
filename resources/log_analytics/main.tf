resource "azurerm_log_analytics_workspace" "example" {
  name                = "${var.client_code}-${var.az_region_code}-${var.tags.tag-Environment}-${var.role_code}-LGW"
  location            = var.az_region
  resource_group_name = var.rsg_name
  sku                 = var.lga_sku
  retention_in_days   = 30
}