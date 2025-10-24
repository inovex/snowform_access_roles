variables {
  db = {
    name = "TEST"
  }

  snowflake_user = "testuser"

  schemas = [
    {
      name = "RAW"
    },
    {
      name = "EXPORT"
    }
  ]
}

mock_provider "snowflake" {
  alias = "mockprovider"
}

run "test_privileges_of_role_full" {
  command = plan

  providers = {
    snowflake.sysadmin      = snowflake.mockprovider
    snowflake.securityadmin = snowflake.mockprovider
    snowflake.useradmin     = snowflake.mockprovider
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_all_on_db_schema_full["RAW"].account_role_name == "TEST_RAW_FULL"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_all_on_db_schema_full["RAW"].all_privileges == true
    error_message = "All privileges flag is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_all_on_db_schema_full["RAW"].on_schema[0].schema_name == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_all_on_db_schema_full["EXPORT"].account_role_name == "TEST_EXPORT_FULL"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_all_on_db_schema_full["EXPORT"].all_privileges == true
    error_message = "All privileges flag is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_all_on_db_schema_full["EXPORT"].on_schema[0].schema_name == "\"TEST\".\"EXPORT\""
    error_message = "Schema name is incorrect"
  }
}
