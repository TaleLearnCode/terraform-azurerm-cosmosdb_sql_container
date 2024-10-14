# #############################################################################
# Variables: Cosmos DB SQL Container
# #############################################################################

variable "name" {
  type        = string
  description = "The name of the Cosmos DB SQL container."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group containing the Cosmos DB account in which to create the SQL container."
}

variable "account_name" {
  type        = string
  description = "The name of the Cosmos DB account in which to create the SQL container."
}

variable "database_name" {
  type        = string
  description = "The name of the Cosmos DB SQL Database in which to create the SQL container."
}

variable "partition_key_paths" {
  type        = list(string)
  description = "The partition key paths for the Cosmos DB SQL container."
}

variable "partition_key_kind" {
  type        = string
  default     = "Hash"
  description = "The partition key kind for the Cosmos DB SQL container. Possible values are 'Hash' or 'MultiHash'. Defaults to `Hash`."
}

variable "partition_key_version" {
  type        = number
  default     = 2
  description = "The partition key version for the Cosmos DB SQL container. Possible values are 1 or 2. Defaults to `1`."
}

variable "default_ttl" {
  type        = number
  default     = -1
  description = "The default time-to-live for the Cosmos DB SQL container. The default value is -1, meaning the TTL is disabled."
}

variable "throughput" {
  type        = number
  nullable    = true
  default     = null
  description = "Throughput value which can be null or between 100 and 1000000 in increments of 100"
}

variable "max_throughput" {
  type        = number
  nullable    = true
  default     = null
  description = "The maximum throughput of the Cosmos DB SQL Database."
}

variable "unique_key_paths" {
  type        = list(string)
  default     = []
  description = "The unique key paths for the Cosmos DB SQL container."
}

variable "record_container_name_in_app_configuration" {
  type        = bool
  default     = false
  description = "Should the container name be recorded in the App Configuration? Defaults to false."
}

variable "configuration_store_id" {
  type        = string
  default     = null
  description = "The ID of the App Configuration Store in which to store the container name. This is required if 'record_container_name_in_app_configuration' is set to true."
}

variable "app_configuration_key" {
  type        = string
  default     = null
  description = "The key in the App Configuration Store in which to store the container name. This is required if 'record_container_name_in_app_configuration' is set to true."
}

variable "app_configuration_label" {
  type        = list(string)
  default     = []
  description = "The labels in the App Configuration Store in which to store the container name."
}
