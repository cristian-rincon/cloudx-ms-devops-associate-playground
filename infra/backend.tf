data "azurerm_user_assigned_identity" "backend_identity" {
  name                = "backend-identity"
  resource_group_name = azurerm_resource_group.backend_rg.name
}

resource "azurerm_service_plan" "backend_plan" {
  name                = "backend-plan"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  os_type             = "Linux"

  sku_name = "F1"
}

resource "azurerm_linux_web_app" "backend_app" {
  name                = "backend-app"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  service_plan_id     = azurerm_service_plan.backend_plan.id

  site_config {

  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      data.azurerm_user_assigned_identity.backend_identity.id
    ]
  }

}
