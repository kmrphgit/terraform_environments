output "sa_id" {
    value = azurerm_storage_account.sa.id
}

output "sa_name" {
    value = azurerm_storage_account.sa.name
}

output "sa_primary_key" {
    value = azurerm_storage_account.sa.primary_access_key
}

output "sa_primary_blob_endpoint" {
    value = azurerm_storage_account.sa.primary_blob_endpoint
}