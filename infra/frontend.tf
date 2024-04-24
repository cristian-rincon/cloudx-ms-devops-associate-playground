data "azurerm_user_assigned_identity" "frontend_identity" {
  name                = "frontend-identity"
  resource_group_name = azurerm_resource_group.frontend_rg.name
}


resource "azurerm_service_plan" "frontend_plan" {
  name                = "frontend-plan"
  location            = azurerm_resource_group.frontend_rg.location
  resource_group_name = azurerm_resource_group.frontend_rg.name
  os_type             = "Linux"

  sku_name = "F1"
}

resource "azurerm_linux_web_app" "frontend_app" {
  name                = "frontend-app"
  location            = azurerm_resource_group.frontend_rg.location
  resource_group_name = azurerm_resource_group.frontend_rg.name
  service_plan_id     = azurerm_service_plan.frontend_plan.id

  site_config {

  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      data.azurerm_user_assigned_identity.frontend_identity.id
    ]
  }

}