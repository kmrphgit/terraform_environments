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

variable "tf_state_sa_rsg" {
  type        = string
  description = "Resource group name for Terraform State storage account"
}

variable "tf_state_sa" {
  type        = string
  description = "Name of storage account which will store Terraform state files"
}

