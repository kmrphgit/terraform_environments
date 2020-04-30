output "rsv_id" {
    value = azurerm_recovery_services_vault.vault.id
}

output "rsv_rsg" {
    value = azurerm_recovery_services_vault.vault.resource_group_name
}

output "rsv_name" {
    value = azurerm_recovery_services_vault.vault.name
}

output "backup_policy_id" {
    value = azurerm_backup_policy_vm.example.id
}