variable "rsg_name" {
    type = string
}
variable "az_region" {
    type = string
}
variable "role_code" {
    type = string
}
variable "sa_tier_type" {
    type = string
}
variable "sa_replication_type" {
    type = string
}
variable "tags" {
    type = map(any)
}
