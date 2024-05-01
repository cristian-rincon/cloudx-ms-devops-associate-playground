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
    "SCM_DO_BUILD_DURING_DEPLOYMENT"   = "1"
    "AZURE_KEYVAULT_CLIENTID"          = "4431371e-7ad3-4661-a2d1-0885cb72c951"
    "AZURE_KEYVAULT_RESOURCEENDPOINT"  = "https://cloudx-kv-0a04bd6e.vault.azure.net/"
    "AZURE_KEYVAULT_SCOPE"             = "https://vault.azure.net/.default"
    "AZURE_MANAGED_IDENTITY_CLIENT_ID" = "4431371e-7ad3-4661-a2d1-0885cb72c951"
    "AZURE_MYSQL_HOST"                 = "cloudx-mysqlserver-820548440a04bd6e.mysql.database.azure.com"
    "AZURE_MYSQL_NAME"                 = "cloudx-mysqldb-820548440a04bd6e"
    "AZURE_MYSQL_PASSWORD"             = "@Microsoft.KeyVault(SecretUri=https://cloudx-kv-0a04bd6e.vault.azure.net/secrets/db-password)"
    "AZURE_MYSQL_USER"                 = "mysqladminun"
    "ENVIRONMENT"                      = "production"
  }

  sticky_settings {
    app_setting_names = [
      "AZURE_MYSQL_NAME",
      "AZURE_MYSQL_HOST",
      "AZURE_MYSQL_USER",
      "AZURE_MYSQL_PASSWORD",
      "AZURE_KEYVAULT_RESOURCEENDPOINT",
      "AZURE_KEYVAULT_CLIENTID",
      "AZURE_KEYVAULT_SCOPE",
    ]
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
