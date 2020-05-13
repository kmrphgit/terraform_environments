variable "rsg_name" {
  type        = string
  description = "Name of VM resource group"
}
variable "az_region" {
  type        = string
  description = "Azure resource region location"
}
variable "environment_code" {
  type        = string
  description = "Short-hand code of SLDC environment (i.e. D = DEV, P = PROD)"
}
variable "role_code" {
  type        = string
  description = "Short-hand code for descriptive name of role for resource group e.g. API, UI, NET, SQL, etc"
}
variable "vm_vnet_rsg_name" {
  type        = string
  description = "Name of vnet resource group"
}
variable "vm_vnet_name" {
  type        = string
  description = "Name of vnet"
}
variable "vm_subnet_name" {
  type        = string
  description = "Name of subnet"
}
variable "vm_sku" {
  type        = string
  description = "VM Sku/Size"
}
variable "vm_count" {
  type        = number
  description = "Number of VMs, network interfaces (NIC) to be deployed"
}
variable "vm_os" {
  type        = string
  description = "String value to select virtual machine operating system; Windows/CentOS"
}
variable "vm_data_disk_count" {
  type        = number
  description = "Number of data disks to be created for virtual machine"
}
variable "vm_rsv_name" {
  type = string
}
variable "vm_rsv_rsg_name" {
  type = string
}
variable "vm_backup_policy_id" {
  type = string
}
variable "tags" {
  type        = map(any)
  description = "Object set for descriptive tags for Azure resources & resource groups"
}
variable "vm_iteration" {
  type        = string
  description = "Iteration of VM(s); example 1 equals first VM to be created 'somevm01' "
}
variable "kv_name" {
  type = string
  description = "String value for name of Key Vault for secret referencing"
}
variable "kv_rsg" {
  type = string
  description = "String value for name of Key Vault resource group for secret referencing"
}
