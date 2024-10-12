variable "environment" {
  type        = string
  default     = "DEV"
  description = "The environment for the resource."
}

data "azurerm_app_configuration" "existing" {
  name                = "existing-appcs"
  resource_group_name = "existing-rg"
}

module "example" {
  source  = "TaleLearnCode/cosmosdb_sql_container/azurerm"
  version = "0.0.1-pre"
  providers = {
    azurerm = azurerm
  }

  name                = "Provisioned"
  resource_group_name = "existing-rg"
  account_name        = "existing-account"
  database_name       = "existing-db"
  throughput          = 400
  partition_key_paths = ["/partitionKey"]

  record_database_name_in_app_configuration = true
  configuration_store_id                    = data.azurerm_app_configuration.existing.id
  app_configuration_key                     = "databaseName"
  app_configuration_label                   = [ "dev" ]
}