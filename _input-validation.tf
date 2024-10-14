## #############################################################################
## Input Validations
## #############################################################################
#
## -----------------------------------------------------------------------------
## throughput must be null or a value between 100 and 1000000 in increments of 100
## -----------------------------------------------------------------------------
#
#locals {
#  valid_throughput = var.throughput == null ? true : (var.throughput % 100 == 0 && var.throughput >= 100 && var.throughput <= 1000000)
#}
#
#resource "null_resource" "validate_throughput_for_valid_value" {
#  count = local.valid_throughput ? 0 : 1
#
#  provisioner "local-exec" {
#    command = "echo 'The throughput must be null or a value between 100 and 1000000 in increments of 100.'"
#  }
#}
#
## -----------------------------------------------------------------------------
## throughput and max_throughput cannot be set at the same time
## -----------------------------------------------------------------------------
#
#locals {
#  both_set = var.throughput != null && var.max_throughput != null
#}
#
#resource "null_resource" "validate_throughput" {
#  count = local.both_set ? 1 : 0
#
#  provisioner "local-exec" {
#    command = "echo 'Error: Both throughput and max_throughput cannot be set at the same time.'; exit 1"
#  }
#}
#
#locals {
#  valid_max_throughput = var.max_throughput == null ? true : (var.max_throughput % 1000 == 0 && var.max_throughput >= 1000 && var.max_throughput <= 1000000)
#}
#
#resource "null_resource" "validate_max_throughput_for_valid_value" {
#  count = local.valid_max_throughput ? 0 : 1
#
#  provisioner "local-exec" {
#    command = "echo 'The max_throughput must be null or a value between 1000 and 1000000 in increments of 1000.'"
#  }
#}
#
## -----------------------------------------------------------------------------
## throughput and max_throughput must be not set when EnableServerless is enabled
## -----------------------------------------------------------------------------
#
#locals {
#  serverless_enabled = contains(data.azurerm_cosmosdb_account.target.capabilities, "EnableServerless")
#  invalid_throughput = (var.throughput != null || var.max_throughput != null) && local.serverless_enabled
#}
#
#resource "null_resource" "validate_serverless_throughput" {
#  count = local.invalid_throughput ? 1 : 0
#
#  provisioner "local-exec" {
#    command = "echo 'Error: throughput and max_throughput cannot be set when EnableServerless is enabled.'; exit 1"
#  }
#}
#
## -----------------------------------------------------------------------------
## configuration_store_id and app_configuration_key must be set when record_container_name_in_app_configuration is true
## -----------------------------------------------------------------------------
#
#locals {
#  invalid_configuration = var.record_container_name_in_app_configuration && (var.configuration_store_id == null || var.app_configuration_key == null)
#}
#
#resource "null_resource" "validate_configuration" {
#  count = local.invalid_configuration ? 1 : 0
#
#  provisioner "local-exec" {
#    command = "echo 'Error: configuration_store_id and app_configuration_key must be set when record_container_name_in_app_configuration is true.'; exit 1"
#  }
#}