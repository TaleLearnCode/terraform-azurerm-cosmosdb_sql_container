# Example: Provisioned Cosmos DB NoSQL Container

This module manages a Cosmos DB NoSQL database using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.  This example shows how to use the module to manage a Cosmos DB NoSQL database.

## Example Usage

```hcl
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
```

You are specifying three values:

- **name**: The name of the Cosmos DB SQL Database.
- **resource_group_name**: The name of the Resource Group containing the Cosmos DB account in which to create the SQL database.
- **account_name**: The name of the Cosmos DB account in which to create the SQL Database.
- **database_name**: The name of the Cosmos DB NoSQL database in which to create the SQL container.
- **throughput**: The throughput of the Cosmos DB SQL Database.
- **record_container_name_in_app_configuration**: Indication whether the container name should be recorded in the specified App Configuration.
- **configuration_store_id**: Identifier of the Azure App Configuration store the container name.
- **app_configuration_key**: The key in the App Configuration Store in which to store the container name.
- **app_configuration_label**: The label in the App Configuration Store in which to store the container name.

This will result in an Azure Cosmos DB SQL container named `Provisioned` provisioned to use 400 RU/s separately from the database.