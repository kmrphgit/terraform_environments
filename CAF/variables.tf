variable "WORKSPACE" {
  description = "set in TFC workspace variables"
  default     = ""
}

variable "ENVIRONMENT" {
  description = "set in TFC workspace variables"
  default     = ""
}

variable "locations" {
  default = []
}

variable "settings" {
  default = {}
}

variable "spn" {
  default = {}
}


# variable "compute" {
#   description = "Configuration object - Azure compute resources"
#   default = {
#     virtual_machines = {}
#   }
# }

# variable "database" {
#   description = "Configuration object - databases resources"
#   default     = {}
# }

# ## Networking variables
# variable "networking" {
#   description = "Configuration object - networking resources"
#   default     = {}
# }

# ## Security variables
# variable "security" {
#   description = "Configuration object - security resources"
#   default     = {}
# }

# variable "keyvaults" {
#   description = "Configuration object - Azure Key Vault resources"
#   default     = {}
# }

# variable "keyvault_access_policies" {
#   description = "Configuration object - Azure Key Vault policies"
#   default     = {}
# }

# variable "storage_accounts" {
#   description = "Configuration object - Storage account resources"
#   default     = {}
# }

# variable "log_analytics" {
#   description = "Configuration object - Log Analytics resources."
#   default     = {}
# }

# variable "subscriptions" {
#   description = "Configuration object - Subscriptions."
#   default     = {}
# }

# variable "identity_settings" {
#   description = "Configuration object - Identity."
#   default     = {}
# }

# variable "management_settings" {
#   description = "Configuration object - Management."
#   default     = {}
# }

