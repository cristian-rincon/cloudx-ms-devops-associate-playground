resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                = "${var.prefix}-mysqlserver-${var.identifier}"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  administrator_login    = "mysqladminun"
  administrator_password = "HASh1CoR3!"

  sku_name = "GP_Standard_D2ds_v4"
  version  = "8.0.21"
}

resource "azurerm_mysql_flexible_database" "mysql_db" {
  name                = "${var.prefix}-mysqldb-${var.identifier}"
  resource_group_name = azurerm_resource_group.backend_rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
