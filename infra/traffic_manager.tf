resource "azurerm_traffic_manager_profile" "app_tm" {
  name                   = "app-tm"
  resource_group_name    = azurerm_resource_group.frontend_rg.name
  profile_status         = "Enabled"
  traffic_routing_method = "Priority"
  dns_config {
    relative_name = "app-tm"
    ttl           = 60
  }
  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
  tags = {
    environment = "production"
  }

}