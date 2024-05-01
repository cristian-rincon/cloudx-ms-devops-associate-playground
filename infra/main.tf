data "azurerm_client_config" "current" {}


# resource "random_id" "rng" {
#   keepers = {
#     first = "${timestamp()}"
#   }
#   byte_length = 8
# }