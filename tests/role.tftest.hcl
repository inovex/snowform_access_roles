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

run "test_create_roles" {
  command = plan

  providers = {
    snowflake.sysadmin      = snowflake.mockprovider
    snowflake.securityadmin = snowflake.mockprovider
    snowflake.useradmin     = snowflake.mockprovider
  }

  assert {
    condition     = snowflake_account_role.r["RAW"].name == "TEST_RAW_R"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_account_role.r["EXPORT"].name == "TEST_EXPORT_R"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_account_role.rw["RAW"].name == "TEST_RAW_RW"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_account_role.rw["EXPORT"].name == "TEST_EXPORT_RW"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_account_role.full["RAW"].name == "TEST_RAW_FULL"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_account_role.full["EXPORT"].name == "TEST_EXPORT_FULL"
    error_message = "Role name is incorrect"
  }
}
