module "lga" {
  source = "../../../modules/log_analytics"
  key_vault_settings = {
    name = module.environment.key_vault_sku
  }
}