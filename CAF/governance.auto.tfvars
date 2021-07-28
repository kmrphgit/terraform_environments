governance = {
  prod_eastus2 = {
    applicationName = "governance"
    environment     = "prod"
    mg_settings = {
      platform = {
        name = "platform"
      }
      prod = {
        name   = "production"
        parent = "platform"
      }
      nonprod = {
        name   = "nonprod"
        parent = "platform"
      }
    }
  }
}
