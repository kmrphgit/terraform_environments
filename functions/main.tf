resource "azurerm_function_app" "function" {
  name                = "${var.client_code}-${upper(var.az_region_code)}-${var.tags.tag-Environment}-${var.role_code}-FUNCTION"
  location            = var.az_region
  resource_group_name = var.rsg_name
  app_service_plan_id = var.app_service_plan_id

  tags                       = var.tags
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
}
