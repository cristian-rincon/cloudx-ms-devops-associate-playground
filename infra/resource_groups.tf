resource "azurerm_resource_group" "frontend_rg" {
  name       = "${var.prefix}-frontend-rg-${var.identifier}"
  location   = "East US"
  managed_by = "Cristian_Rincon@epam.com"
}

resource "azurerm_resource_group" "backend_rg" {
  name       = "${var.prefix}-backend-rg-${var.identifier}"
  location   = "North Central US"
  managed_by = "Cristian_Rincon@epam.com"
}