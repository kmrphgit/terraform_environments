variable "client_code" {
    type        = string
    description = "Client alpha-numeric code for naming Azure resources"
}
variable "tags" {
    type        = map(any)
    description = "Object set for descriptive tags for Azure resources & resource groups"
}

variable "az_region" {
    type        = string
    description = "Azure formatted description for resource region" 
}
variable "az_region_code" {
    type        = string
    description = "Short-hand code for Azure region used in resource naming"
}

variable "role_code" {
    type        = string
    description = "Short-hand code for descriptive name of role for resource group e.g. API, UI, NET, SQL, etc"
}