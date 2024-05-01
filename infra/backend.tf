resource "azurerm_user_assigned_identity" "backend_identity" {
  name                = "${var.prefix}-backend-identity-${var.identifier}"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  depends_on = [azurerm_resource_group.backend_rg]
}


resource "azurerm_service_plan" "backend_plan" {
  name                = "${var.prefix}-backend-plan-${var.identifier}"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  os_type             = "Linux"

  sku_name = "F1"

  depends_on = [azurerm_resource_group.backend_rg]
}

resource "azurerm_linux_web_app" "backend_app" {
  name                = "${var.prefix}-backend-app-${var.identifier}"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  service_plan_id     = azurerm_service_plan.backend_plan.id

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "1"
  }

  site_config {
    always_on        = false
    app_command_line = "python -m uvicorn app.main:app --host 0.0.0.0"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.backend_identity.id
    ]
  }

  depends_on = [azurerm_service_plan.backend_plan]
}
