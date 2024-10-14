# Example: Serverless Cosmos DB NoSQL Container

This module manages a Cosmos DB NoSQL database using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.  This example shows how to use the module to manage a Cosmos DB NoSQL database.

## Example Usage

```hcl
variable "environment" {
  type        = string
  default     = "DEV"
  description = "The environment for the resource."
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "North Central US"
}

data "azurerm_app_configuration" "example" {
  name                = "existing"
  resource_group_name = "existing"
}

data "azurerm_cosmosdb_account" "example" {
  name                = "tfex-cosmosdb-account"
  resource_group_name = "tfex-cosmosdb-account-rg"
}

data "azurerm_cosmosdb_sql_database" "example" {
  name                = "example-acsd"
  resource_group_name = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.example.name
}

module "example" {
  source  = "TaleLearnCode/cosmosdb_sql_database/azurerm"
  version = "0.0.2"
  providers = {
    azurerm = azurerm
  }

  name                = "Provisioned"
  resource_group_name = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.example.name
  database_name       = data.azurerm_cosmosdb_sql_database.example.name
  throughput          = 400
  partition_key_paths = ["/partitionKey"]

  record_database_name_in_app_configuration = true
  configuration_store_id                    = data.azurerm_app_configuration.example.id
  app_configuration_key                     = "databaseName"
  app_configuration_label                   = [ "dev" ]
}
```

You are specifying three values:

- **name**: The name of the Cosmos DB NoSQL Database.
- **resource_group_name**: The name of the Resource Group containing the Cosmos DB account in which to create the NoSQL database.
- **account_name**: The name of the Cosmos DB account in which to create the SQL Database.
- **database_name**: The name of the Cosmos DB NoSQL database in which to create the SQL container.
- **throughput**: The throughput of the Cosmos DB NoSQL Database.
- **record_container_name_in_app_configuration**: Indication whether the container name should be recorded in the specified App Configuration.
- **configuration_store_id**: Identifier of the Azure App Configuration store the container name.
- **app_configuration_key**: The key in the App Configuration Store in which to store the container name.
- **app_configuration_label**: The label in the App Configuration Store in which to store the container name.

This will result in an Azure Cosmos DB SQL container named `Serverless` without providing a specific throughput input (as the database uses serverless provisioning).