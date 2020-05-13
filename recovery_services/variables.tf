variable "rsg_name" {
  type        = string
  description = "Name of VM resource group"
}
variable "az_region" {
  type        = string
  description = "Azure resource region location"
}
variable "role_code" {
  type        = string
  description = "Short-hand code for descriptive name of role for resource group e.g. API, UI, NET, SQL, etc"
}
variable "rsv_sa_id" {
  type = string
}
variable "rsv_sku" {
  type = string
}
variable "tags" {
  type        = map(any)
  description = "Object set for descriptive tags for Azure resources & resource groups"
}

