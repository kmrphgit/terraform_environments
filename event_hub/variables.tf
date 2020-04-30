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

variable "event_hub_sku" {
  type        = string
  description = "Event Hub SKU (i.e. Standard)"
}

variable "event_hub_capacity" {
  type        = number
  description = "Event Hub capacity to be provisioned (i.e. 1 Namespace)"
}

variable "event_hub_message_retention" {
    type = number
    description = "Event Hub message retention setting (i.e. 1 = 1 day)"
}

variable "event_hub_partition_count" {
    type = number
    description = "Event Hub partition count (i.e. 2 = 2 partitions to be provisioned)"
}
