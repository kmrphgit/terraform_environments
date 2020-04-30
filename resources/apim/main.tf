resource "azurerm_api_management" "apim" {
  name                = "${var.client_code}-${upper(var.az_region_code)}-${var.tags.tag-Environment}-${var.role_code}-APIM"
  location            = var.az_region
  resource_group_name = var.rsg_name
  publisher_name      = "Kloudmorph"
  publisher_email     = "will.barbier@kloudmorph.com"

  sku_name = "Developer_1"

  policy {
    xml_content = <<XML
    <policies>
      <inbound />
      <backend />
      <outbound />
      <on-error />
    </policies>
XML

  }

  tags = var.tags
}
