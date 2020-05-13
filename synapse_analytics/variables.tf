variable "rsg_name" {
  type        = string
  description = "Name of VM resource group"
}

variable "role_code" {
  type        = string
  description = "Short-hand code for descriptive name of role for resource group e.g. API, UI, NET, SQL, etc"
}

variable "tags" {
    type        = map(any)
    description = "Object set for descriptive tags for Azure resources & resource groups"
}

variable "sql_sa_endpoint" {
    type = string
}

variable "sql_sa_primary_key" {
    type = string
}