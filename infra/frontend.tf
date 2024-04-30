resource "azurerm_user_assigned_identity" "frontend_identity" {
  name                = "${var.prefix}-frontend-identity-${var.identifier}"
  location            = azurerm_resource_group.frontend_rg.location
  resource_group_name = azurerm_resource_group.frontend_rg.name
}


resource "azurerm_service_plan" "frontend_plan" {
  name                = "${var.prefix}-frontend-plan-${var.identifier}"
  location            = azurerm_resource_group.frontend_rg.location
  resource_group_name = azurerm_resource_group.frontend_rg.name
  os_type             = "Linux"

  sku_name = "F1"

  depends_on = [ azurerm_resource_group.frontend_rg ]
}

resource "azurerm_linux_web_app" "frontend_app" {
  name                = "${var.prefix}-frontend-app-${var.identifier}"
  location            = azurerm_resource_group.frontend_rg.location
  resource_group_name = azurerm_resource_group.frontend_rg.name
  service_plan_id     = azurerm_service_plan.frontend_plan.id

  site_config {
    always_on = false
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.frontend_identity.id
    ]
  }

  depends_on = [ azurerm_service_plan.frontend_plan ]

}