# #############################################################################
# Outputs
# #############################################################################

output "container" {
  value       = azurerm_cosmosdb_sql_container.target
  description = "The Cosmos DB SQL container."
}

output "app_configuration_key" {
  value       = var.app_configuration_key == "null" ? null : var.app_configuration_key
  description = "The name of the key in the App Configuration Store that contains the name of the container."
}

output "app_configuration_labels" {
  value       = var.app_configuration_label
  description = "The labels in the App Configuration Store in which to store the container name."
}