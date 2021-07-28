resource "azurerm_storage_account" "stg" {
  name                      = "${var.settings.naming_conventions.storage_account}-${var.iteration}"
  location                  = var.settings.location
  account_tier              = try(var.settings.account_tier, "Standard")
  account_replication_type  = try(var.settings.account_replication_type, "LRS")
  account_kind              = try(var.settings.account_kind, "StorageV2")
  access_tier               = try(var.settings.access_tier, "Hot")
  enable_https_traffic_only = try(var.settings.nfsv3_enabled, false) ? false : true
  #if using nfsv3_enabled, then https must be disabled
  min_tls_version          = try(var.settings.min_tls_version, "TLS1_2")
  allow_blob_public_access = try(var.settings.allow_blob_public_access, false)
  is_hns_enabled           = try(var.settings.is_hns_enabled, false)
  nfsv3_enabled            = try(var.settings.nfsv3_enabled, false)
  large_file_share_enabled = try(var.settings.large_file_share_enabled, null)
  #  tags                     = merge(var.base_tags, local.tags)


  dynamic "custom_domain" {
    for_each = lookup(var.settings, "custom_domain", false) == false ? [] : [1]

    content {
      name          = var.settings.custom_domain.name
      use_subdomain = try(var.settings.custom_domain.use_subdomain, null)
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "enable_system_msi", false) == false ? [] : [1]

    content {
      type = "SystemAssigned"
    }
  }

  dynamic "blob_properties" {
    for_each = lookup(var.settings, "blob_properties", false) == false ? [] : [1]

    content {
      versioning_enabled       = try(var.settings.blob_properties.versioning_enabled, false)
      change_feed_enabled      = try(var.settings.blob_properties.change_feed_enabled, false)
      default_service_version  = try(var.settings.blob_properties.default_service_version, "2020-06-12")
      last_access_time_enabled = try(var.settings.blob_properties.last_access_time_enabled, false)

      dynamic "cors_rule" {
        for_each = lookup(var.settings.blob_properties, "cors_rule", false) == false ? [] : [1]

        content {
          allowed_headers    = var.settings.blob_properties.cors_rule.allowed_headers
          allowed_methods    = var.settings.blob_properties.cors_rule.allowed_methods
          allowed_origins    = var.settings.blob_properties.cors_rule.allowed_origins
          exposed_headers    = var.settings.blob_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.settings.blob_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = lookup(var.settings.blob_properties, "delete_retention_policy", false) == false ? [] : [1]

        content {
          days = try(var.settings.blob_properties.delete_retention_policy.delete_retention_policy, 7)
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = lookup(var.settings.blob_properties, "container_delete_retention_policy", false) == false ? [] : [1]

        content {
          days = try(var.settings.blob_properties.container_delete_retention_policy.container_delete_retention_policy, 7)
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = lookup(var.settings, "queue_properties", false) == false ? [] : [1]

    content {
      dynamic "cors_rule" {
        for_each = lookup(var.settings.queue_properties, "cors_rule", false) == false ? [] : [1]

        content {
          allowed_headers    = var.settings.queue_properties.cors_rule.allowed_headers
          allowed_methods    = var.settings.queue_properties.cors_rule.allowed_methods
          allowed_origins    = var.settings.queue_properties.cors_rule.allowed_origins
          exposed_headers    = var.settings.queue_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.settings.queue_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "logging" {
        for_each = lookup(var.settings.queue_properties, "logging", false) == false ? [] : [1]

        content {
          delete                = var.settings.queue_properties.logging.delete
          read                  = var.settings.queue_properties.logging.read
          write                 = var.settings.queue_properties.logging.write
          version               = var.settings.queue_properties.logging.version
          retention_policy_days = try(var.settings.queue_properties.logging.retention_policy_days, 7)
        }
      }

      dynamic "minute_metrics" {
        for_each = lookup(var.settings.queue_properties, "minute_metrics", false) == false ? [] : [1]

        content {
          enabled               = var.settings.queue_properties.minute_metrics.enabled
          version               = var.settings.queue_properties.minute_metrics.version
          include_apis          = try(var.settings.queue_properties.minute_metrics.include_apis, null)
          retention_policy_days = try(var.settings.queue_properties.minute_metrics.retention_policy_days, 7)
        }
      }

      dynamic "hour_metrics" {
        for_each = lookup(var.settings.queue_properties, "hour_metrics", false) == false ? [] : [1]

        content {
          enabled               = var.settings.queue_properties.hour_metrics.enabled
          version               = var.settings.queue_properties.hour_metrics.version
          include_apis          = try(var.settings.queue_properties.hour_metrics.include_apis, null)
          retention_policy_days = try(var.settings.queue_properties.hour_metrics.retention_policy_days, 7)
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = lookup(var.settings, "static_website", false) == false ? [] : [1]

    content {
      index_document     = try(var.settings.static_website.index_document, null)
      error_404_document = try(var.settings.static_website.error_404_document, null)
    }
  }

  dynamic "network_rules" {
    for_each = lookup(var.settings, "network", null) == null ? [] : [1]
    content {
      bypass         = try(var.settings.network.bypass, [])
      default_action = try(var.settings.network.default_action, "Deny")
      ip_rules       = try(var.settings.network.ip_rules, [])
      virtual_network_subnet_ids = try(var.settings.network.subnets, null) == null ? null : [
        for key, value in var.settings.network.subnets : try(var.vnets[var.client_config.landingzone_key][value.vnet_key].subnets[value.subnet_key].id, var.vnets[value.lz_key][value.vnet_key].subnets[value.subnet_key].id)
      ]
    }
  }

  dynamic "azure_files_authentication" {
    for_each = lookup(var.settings, "azure_files_authentication", false) == false ? [] : [1]

    content {
      directory_type = var.settings.azure_files_authentication.directory_type

      dynamic "active_directory" {
        for_each = lookup(var.settings.azure_files_authentication, "active_directory", false) == false ? [] : [1]

        content {
          storage_sid         = var.settings.azure_files_authentication.active_directory.storage_sid
          domain_name         = var.settings.azure_files_authentication.active_directory.domain_name
          domain_sid          = var.settings.azure_files_authentication.active_directory.domain_sid
          domain_guid         = var.settings.azure_files_authentication.active_directory.domain_guid
          forest_name         = var.settings.azure_files_authentication.active_directory.forest_name
          netbios_domain_name = var.settings.azure_files_authentication.active_directory.netbios_domain_name
        }
      }
    }
  }

  dynamic "routing" {
    for_each = lookup(var.settings, "routing", false) == false ? [] : [1]

    content {
      publish_internet_endpoints  = try(var.settings.routing.publish_internet_endpoints, false)
      publish_microsoft_endpoints = try(var.settings.routing.publish_microsoft_endpoints, false)
      choice                      = try(var.settings.routing.choice, "MicrosoftRouting")
    }
  }
}

module "queue" {
  source   = "./queue"
  for_each = try(var.settings.queues, {})

  storage_account_name = azurerm_storage_account.stg.name
  settings             = each.value
}

module "container" {
  source   = "./container"
  for_each = try(var.settings.containers, {})

  storage_account_name = azurerm_storage_account.stg.name
  settings             = each.value
}

module "data_lake_filesystem" {
  source   = "./data_lake_filesystem"
  for_each = try(var.settings.data_lake_filesystems, {})

  storage_account_id = azurerm_storage_account.stg.id
  settings           = each.value
}

module "file_share" {
  source     = "./file_share"
  for_each   = try(var.settings.file_shares, {})
  depends_on = [azurerm_backup_container_storage_account.container]

  storage_account_name = azurerm_storage_account.stg.name
  storage_account_id   = azurerm_storage_account.stg.id
  settings             = each.value
  recovery_vault       = local.recovery_vault
  resource_group_name  = var.resource_group_name
}