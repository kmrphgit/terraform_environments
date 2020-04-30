variable "client_code" {
  type        = string
  description = "Client alpha-numeric code for naming Azure resources"
}

variable "rsg_name" {
  type        = string
  description = "Name of VM resource group"
}

variable "az_region" {
  type        = string
  description = "Azure resource region location"
}

variable "az_region_code" {
  type        = string
  description = "Short-hand code for Azure region used in resource naming"
}

variable "role_code" {
  type        = string
  description = "Short-hand code for descriptive name of role for resource group e.g. API, UI, NET, SQL, etc"
}

variable "tags" {
    type        = map(any)
    description = "Object set for descriptive tags for Azure resources & resource groups"
}

variable "cosmosDB_failover_location" {
  type = string
  description = "Cosmos DB failover Azure Region; region Azure will failover to (i.e. WestUS2)"
}
