terraform {
  required_version = ">= 1.7"
  required_providers {
    snowflake = {
      source                = "snowflakedb/snowflake"
      version               = ">= 2.1.0, < 3.0.0"
      configuration_aliases = [snowflake.useradmin, snowflake.sysadmin, snowflake.securityadmin]
    }
  }
}
