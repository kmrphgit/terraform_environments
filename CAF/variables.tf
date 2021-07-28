variable "WORKSPACE" {
  description = "set in TFC workspace variables"
  default     = ""
}

variable "ENVIRONMENT" {
  description = "set in TFC workspace variables"
  default     = ""
}

variable "identity_nonprod" {
  default = {}
}

variable "identity_prod" {
  default = {}
}

variable "governance" {
  default = {}
}

variable "management" {
  default = {}
}

variable "connectivity_nonprod" {
  default = {}
}

variable "connectivity_prod" {
  default = {}
}

variable "devops_prod" {
  default = {}
}

variable "spn" {
  default = {}
}

