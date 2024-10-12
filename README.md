# Azure Cosmos DB NoSQL Container Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md)

This module manages Azure Cosmos DB accounts using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.

## Providers

| Name    | Version |
| ------- | ------- |
| azurerm | ~> 4.1. |

## Modules

No modules.

## Resources

No resources.

## Usage

```hcl
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

For more detailed instructions on using this module: please refer to the appropriate example:

- [Autoscaled](examples/autoscaled/README.md)
- [Provisioned](examples/provisioned/README.md)
- [Serverless](examples/serverless/README.md)

## Inputs

| Name                                  | Description                                                  | Type              | Default            | Required |
| ------------------------------------- | ------------------------------------------------------------ | ----------------- | ------------------ | -------- |
| account_name | The name of the Cosmos DB account in which to create the SQL container. | string | N/A | **yes** |
| app_configuration_key | The key in the App Configuration Store in which to store the container name. This is required if `record_database_name_in_app_configuration` is set to true. | string | null | no |
| app_configuration_label | The label(s) in the App Configuration Store in which to store the container  name. | list(string) | [] | no |
| default_ttl | The default time-to-live for the Cosmos DB SQL container. The default value is -1, meaning the TTL is disabled. | number | -1 | no |
| name            | The name of the Cosmos DB NoSQL container . | string         | N/A            | **yes** |
| configuration_store_id | The ID of the App Configuration Store in which to store the database name. This is required if `record_database_name_in_app_configuration` is set to true. | string | null | no |
| database_name | The name of the Cosmos DB SQL Database in which to create the SQL container. | string | N/A | **yes** |
| max_throughput | The maximum throughput of the Cosmos DB SQL Database. | number | null | no |
| partition_key_kind | The partition key kind for the Cosmos DB SQL container. Possible values are 'Hash' or 'MultiHash'. Defaults to `Hash`. | string | `Hash` | no |
| partition_key_paths | The partition key paths for the Cosmos DB SQL container. | list(string) | N/A | **yes** |
| partition_key_version | The partition key version for the Cosmos DB SQL container. Possible values are 1 or 2. Defaults to `1`. | number | 1 | no |
| record_database_name_in_app_configuration | Should the database name be recorded in the App Configuration? Defaults to false. | bool | false | no |
| resource_group_name | The name of the Resource Group containing the Cosmos DB account in which to create the SQL database. | string | N/A | **yes** |
| throughput | The throughput of the Cosmos DB SQL Database. | number | null | no |
| unique_key_paths | The unique key paths for the Cosmos DB SQL container. | list(string) | [] | no |

## Outputs

| Name                     | Description                                                  |
| ------------------------ | ------------------------------------------------------------ |
| container_name           | The name of the managed Cosmos DB NoSQL container.           |
| app_configuration_key    | The name of the key in the App Configuration Store that contains the name of the container. |
| app_configuration_labels | The labels in the App Configuration Store in which to store the container name. |

## Naming Guidelines

### Cosmos DB NoSQL Database

| Guideline                       |                                               |
| ------------------------------- | --------------------------------------------- |
| Resource Type Identifier        | N/A                                           |
| Scope                           | Cosmos DB Account                             |
| Max Overall Length              | 1 - 256 characters                            |
| Allowed Component Name Length * | N/A                                           |
| Valid Characters                | Alphanumeric and hyphens                      |
| Regex                           | `^(?!-)(?!.*--)[A-Za-z0-9]+(-[A-Za-z0-9]+)*$` |