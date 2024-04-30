resource "azurerm_traffic_manager_profile" "cloudx_app_tm" {
  name                   = "${var.prefix}-app-tm-${var.identifier}"
  resource_group_name    = azurerm_resource_group.frontend_rg.name
  profile_status         = "Enabled"
  traffic_routing_method = "Priority"
  dns_config {
    relative_name = "${var.prefix}-app-tm-${var.identifier}"
    ttl           = 60
  }
  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
  tags = {
    environment = "${var.environment}"
  }

  depends_on = [
    azurerm_resource_group.frontend_rg
  ]
}