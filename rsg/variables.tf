variable "tags" {
  type        = map(any)
  description = "Object set for descriptive tags for Azure resources & resource groups"
}
variable "role_code" {
  type        = string
  description = "Short-hand code for descriptive name of role for resource group e.g. API, UI, NET, SQL, etc"
}
# variable "tf_state_sa_rsg" {
#   type        = string
#   description = "Resource group name for Terraform State storage account"
# }
# variable "tf_state_sa" {
#   type        = string
#   description = "Name of storage account which will store Terraform state files"
# }
