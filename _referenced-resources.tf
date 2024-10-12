# #############################################################################
# Referenced resources
# #############################################################################

data "azurerm_cosmosdb_account" "target" {
  name                = var.account_name
  resource_group_name = var.resource_group_name
}