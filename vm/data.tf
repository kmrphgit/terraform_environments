data "azurerm_subnet" "subnet" {
  name                 = var.vm_subnet_name
  virtual_network_name = var.vm_vnet_name
  resource_group_name  = var.vm_vnet_rsg_name
}

data "azurerm_key_vault" "key_vault" {
  name                = "KMH-EU2-DEV-KV-kv"
  resource_group_name = "KMH-EU2-DEV-HUB-RSG"
}
data "azurerm_key_vault_secret" "admin_username" {
  name         = "server-admin-username"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "admin_pw" {
  name         = "server-admin-username"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}