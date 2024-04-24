resource "azurerm_resource_group" "frontend_rg" {
  name     = "frontend-rg"
  location = "East US"
  managed_by = "Cristian_Rincon@epam.com"
}

resource "azurerm_resource_group" "backend_rg" {
  name     = "backend-rg"
  location = "Central US"
  managed_by = "Cristian_Rincon@epam.com"
}