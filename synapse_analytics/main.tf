resource "azurerm_sql_server" "sql_server" {
  name                         = "mysqlserver"
  resource_group_name          = var.rsg_name
  location                     = local.az_region
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "4v3ry53cr37p455w0rd"

  tags = var.tags
}

resource "azurerm_sql_database" "synapse_db" {
  name                = "${local.synapse_name_prefix}${var.role_code}sqldw"
  resource_group_name = var.rsg_name
  location            = azurerm_sql_server.sql_server.location
  server_name         = azurerm_sql_server.sql_server.name
  edition             = "DataWarehouse"

  extended_auditing_policy {
    storage_endpoint                        = var.sql_sa_endpoint
    storage_account_access_key              = var.sql_sa_primary_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}