resource "azurerm_key_vault" "app_kv" {
  name                = "${var.prefix}-kv-${var.short_identifier}"
  location            = azurerm_resource_group.frontend_rg.location
  resource_group_name = azurerm_resource_group.frontend_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]
  }

  tags = {
    environment = "${var.environment}"
  }

  depends_on = [
    azurerm_resource_group.frontend_rg
  ]
}