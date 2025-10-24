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

run "test_role_hierarchy" {
  command = plan

  providers = {
    snowflake.sysadmin      = snowflake.mockprovider
    snowflake.securityadmin = snowflake.mockprovider
    snowflake.useradmin     = snowflake.mockprovider
  }

  assert {
    condition     = snowflake_grant_account_role.r_grants_sysadmin["RAW"].role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.r_grants_sysadmin["RAW"].parent_role_name == "SYSADMIN"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.r_grants_sysadmin["EXPORT"].role_name == "TEST_EXPORT_R"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.r_grants_sysadmin["EXPORT"].parent_role_name == "SYSADMIN"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.r_grants_read_write["RAW"].role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.r_grants_read_write["RAW"].parent_role_name == "TEST_RAW_RW"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.r_grants_read_write["EXPORT"].role_name == "TEST_EXPORT_R"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.r_grants_read_write["EXPORT"].parent_role_name == "TEST_EXPORT_RW"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_rw_grants_sysadmin["RAW"].role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_rw_grants_sysadmin["RAW"].parent_role_name == "SYSADMIN"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_rw_grants_sysadmin["EXPORT"].role_name == "TEST_EXPORT_RW"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_rw_grants_sysadmin["EXPORT"].parent_role_name == "SYSADMIN"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_rw_grants_full["RAW"].role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_rw_grants_full["RAW"].parent_role_name == "TEST_RAW_FULL"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_rw_grants_full["EXPORT"].role_name == "TEST_EXPORT_RW"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_rw_grants_full["EXPORT"].parent_role_name == "TEST_EXPORT_FULL"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_full_grants_sysadmin["RAW"].role_name == "TEST_RAW_FULL"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_full_grants_sysadmin["RAW"].parent_role_name == "SYSADMIN"
    error_message = "Parent role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_full_grants_sysadmin["EXPORT"].role_name == "TEST_EXPORT_FULL"
    error_message = "Role name is incorrect"
  }

  assert {
    condition     = snowflake_grant_account_role.role_full_grants_sysadmin["EXPORT"].parent_role_name == "SYSADMIN"
    error_message = "Parent role name is incorrect"
  }
}
