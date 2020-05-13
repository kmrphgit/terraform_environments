variable "tags" {
  type        = map(any)
  description = "Object set for descriptive tags for Azure resources & resource groups"
}
variable "role_code" {
  type        = string
  description = "Short-hand code for descriptive name of role for resource group e.g. API, UI, NET, SQL, etc"
}
variable "rsg_name" {
  type        = string
  description = "Dynamically obtained name for resource group to deploy resources to; from rsg module"
}
variable "subnet_address_spaces" {
  type        = map(any)
  description = "List of subnet address space(s) for each subnet to be deployed in cidr notation e.g. 10.1.0.0/24"
}
variable "subnet_names" {
  type        = list(string)
  description = "List of subnet names(s) for each subnet to be deployed"
}
variable "vnet_address_space" {
  type        = map(any)
  description = "List of vnet address space(s) to be used for a single vnet deployment in cidr notation e.g. 10.1.0.0/16"
}
