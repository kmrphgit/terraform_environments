output "devops_prod" {
  value = var.settings
}

output "networking" {
  value = module.networking
}

output "private_dns" {
  value = module.private_dns
}

output "arv" {
  value = module.arv
}

output "rg" {
  value = module.rg
}

output "aks" {
  value = module.aks
}

output "acr" {
  value = module.acr
}