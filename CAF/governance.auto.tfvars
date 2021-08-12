governance = {
  prod_eastus2 = {
    applicationName = "governance"
    environment     = "prod"
    location        = "primary"
    mg_settings = {
      top_level = {
        platform = {
          name = "platform"
        }
        prod = {
          name = "prod"
        }
        nonprod = {
          name = "nonprod"
        }
      }
      child_level = {
        example = {
          name       = "example"
          parent_key = "nonprod"
        }
      }
    }
  }
}
