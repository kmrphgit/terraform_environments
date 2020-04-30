resource "azurerm_eventhub_namespace" "event_hub_namespace" {
  name                = "${var.client_code}-${upper(var.az_region_code)}-${var.tags.tag-Environment}-${var.role_code}-EHUB"
  location            = var.az_region
  resource_group_name = var.rsg_name
  sku                 = var.event_hub_sku #"Standard"
  capacity            = var.event_hub_capacity #1 (number)

  tags = var.tags
}

resource "azurerm_eventhub" "event_hub" {
  name                = "acceptanceTestEventHub"
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  resource_group_name = var.rsg_name
  partition_count     = var.event_hub_partition_count #2 (number)
  message_retention   = var.event_hub_message_retention #1 (number)
}