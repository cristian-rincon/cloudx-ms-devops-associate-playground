resource "azurerm_key_vault" "app_kv" {
  name                = "app-kv"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
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
    environment = "production"
  }
}