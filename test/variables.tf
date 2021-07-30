variable "environment" {
  default = ""
}

variable "applicationName" {
  default = ""
}

variable "location" {
  default = ""
}


variable "settings" {
  default = {}
}

variable "spn" {
  default = {}
}

variable "billing" {
  default = {}
}

# variable "networks" {
#   type = map(object({
#     name = string
#     subnets    = map(object({ cidr_block = string }))
#   }))
#   default = {
#     name = {
#       name = "test-vnet"
#       subnets = {
#         cidr_block = "10.1.0.0/24"
#       }
#     }
#   }
# }
