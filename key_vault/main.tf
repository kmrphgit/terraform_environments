data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "key_vault" {
  name                        = "${upper(var.client_code)}-${upper(var.az_region_code)}-${upper(var.tags.tag-Environment)}-${upper(var.role_code)}-kv"
  location                    = var.az_region
  resource_group_name         = var.rsg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  purge_protection_enabled    = false

  sku_name = "standard"

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "kv_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]
}
