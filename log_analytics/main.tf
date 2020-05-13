terraform {
  backend "azurerm" {}
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "${local.common_name_prefix}-${var.role_code}-LGW"
  location            = var.az_region
  resource_group_name = var.rsg_name
  sku                 = var.lga_sku
  retention_in_days   = 30
}