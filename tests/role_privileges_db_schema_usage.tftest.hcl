variables {
  db = {
    name = "TEST"
  }

  snowflake_user = "testuser"

  schemas = [
    {
      name = "RAW"
    }
  ]
}

mock_provider "snowflake" {
  alias = "mockprovider"
}

run "test_usage_privileges_on_db_schema" {
  command = plan

  providers = {
    snowflake.sysadmin      = snowflake.mockprovider
    snowflake.securityadmin = snowflake.mockprovider
    snowflake.useradmin     = snowflake.mockprovider
  }

  # DB usage
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_r["RAW"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_r["RAW"].privileges == toset(["USAGE"])
    error_message = "Privilege is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_r["RAW"].on_account_object[0].object_type == "DATABASE"
    error_message = "Account object type is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_r["RAW"].on_account_object[0].object_name == "TEST"
    error_message = "Account object name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_rw["RAW"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_rw["RAW"].privileges == toset(["USAGE"])
    error_message = "Privilege is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_rw["RAW"].on_account_object[0].object_type == "DATABASE"
    error_message = "Account object type is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_rw["RAW"].on_account_object[0].object_name == "TEST"
    error_message = "Account object name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_full["RAW"].account_role_name == "TEST_RAW_FULL"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_full["RAW"].privileges == toset(["USAGE"])
    error_message = "Privilege is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_full["RAW"].on_account_object[0].object_type == "DATABASE"
    error_message = "Account object type is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_full["RAW"].on_account_object[0].object_name == "TEST"
    error_message = "Account object name is incorrect"
  }

  # schema usage
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_r["RAW"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_r["RAW"].privileges == toset(["USAGE"])
    error_message = "Privilege is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_r["RAW"].on_schema[0].schema_name == "\"TEST\".\"RAW\""
    error_message = "Account object type is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_rw["RAW"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_rw["RAW"].privileges == toset(["USAGE"])
    error_message = "Privilege is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_rw["RAW"].on_schema[0].schema_name == "\"TEST\".\"RAW\""
    error_message = "Account object type is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_full["RAW"].account_role_name == "TEST_RAW_FULL"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_full["RAW"].privileges == toset(["USAGE"])
    error_message = "Privilege is incorrect"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_usage_on_db_schema_full["RAW"].on_schema[0].schema_name == "\"TEST\".\"RAW\""
    error_message = "Account object type is incorrect"
  }
}
