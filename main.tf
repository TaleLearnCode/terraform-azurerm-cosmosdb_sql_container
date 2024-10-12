# #############################################################################
# Terraform Module: Cosmos DB SQL Database
# #############################################################################

resource "azurerm_cosmosdb_sql_container" "target" {
  name                = var.name
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  database_name       = var.database_name

  partition_key_paths   = var.partition_key_paths
  partition_key_kind    = var.partition_key_kind
  partition_key_version = var.partition_key_version

  default_ttl = var.default_ttl

  throughput          = var.throughput != null ? var.throughput : null
  dynamic "autoscale_settings" {
    for_each = var.max_throughput != null ? [1] : []
    content {
      max_throughput = var.max_throughput
    }
  }

  dynamic "unique_key" {
    for_each = length(var.unique_key_paths) > 0 ? [1] : []
    content {
      paths = var.unique_key_paths
    }
  }
}

locals {
  labels = var.record_container_name_in_app_configuration ? (length(var.app_configuration_label) > 0 ? var.app_configuration_label : ["default"]) : []
}

resource "azurerm_app_configuration_key" "target" {
  for_each               = toset(local.labels)
  configuration_store_id = var.configuration_store_id
  key                    = var.app_configuration_key
  value                  = azurerm_cosmosdb_sql_container.target.name
  depends_on             = [ data.azurerm_cosmosdb_account.target ]

  label = each.value != "default" ? each.value : null
}