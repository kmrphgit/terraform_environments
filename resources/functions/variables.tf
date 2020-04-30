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

variable "app_service_plan_id" {
  type        = string
  description = "Azure resource ID, GUID format, for App Service Plan"
}

variable "tags" {
  type        = map(any)
  description = "Object set for descriptive tags for Azure resources & resource groups"
}

variable "storage_account_name" {
  type        = string
  description = "String name of dependent storage account for Function App"
}

variable "storage_account_access_key" {
  type        = string
  description = "String GUID of dependent storage account for Function App"
}
