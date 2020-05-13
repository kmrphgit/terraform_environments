terraform {
  backend "azurerm" {}
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = "${local.common_name_prefix}-${var.role_code}-RSV"
  location            = var.az_region
  resource_group_name = var.rsg_name
  sku                 = var.rsv_sku

  soft_delete_enabled = false
}

resource "azurerm_backup_container_storage_account" "vm_backup" {
  resource_group_name = var.rsg_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  storage_account_id  = var.rsv_sa_id
}

resource "azurerm_backup_policy_vm" "example" {
  name                = "azure-vm-backup-policy"
  resource_group_name = var.rsg_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }
  retention_daily {
    count = 10
  }
}