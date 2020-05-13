variable "tags" {
  type        = map(any)
  description = "Object set for descriptive tags for Azure resources & resource groups"
}
variable "role_code" {
  type        = string
  description = "Short-hand code for descriptive name of role for resource group e.g. API, UI, NET, SQL, etc"
}
# variable "az_region" {
#   type        = string
#   description = "Azure resource region location"
# }