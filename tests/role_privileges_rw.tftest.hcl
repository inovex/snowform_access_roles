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

run "test_privileges_of_role_rw" {
  command = plan

  providers = {
    snowflake.sysadmin      = snowflake.mockprovider
    snowflake.securityadmin = snowflake.mockprovider
    snowflake.useradmin     = snowflake.mockprovider
  }

  # Write privileges on tables
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tables_all"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect for tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tables_all"].privileges == toset(["INSERT", "UPDATE", "DELETE", "TRUNCATE"])
    error_message = "Privileges are incorrect for tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tables_all"].on_schema_object[0].all[0].object_type_plural == "TABLES"
    error_message = "Object type is incorrect for tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tables_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for tables (all)"
  }

  # Write privileges on future tables
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tables_future"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect for tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tables_future"].privileges == toset(["INSERT", "UPDATE", "DELETE", "TRUNCATE"])
    error_message = "Privileges are incorrect for tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tables_future"].on_schema_object[0].future[0].object_type_plural == "TABLES"
    error_message = "Object type is incorrect for tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tables_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for tables (future)"
  }

  # Write privileges on stages
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_stages_all"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect for stages (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_stages_all"].privileges == toset(["WRITE"])
    error_message = "Privileges are incorrect for stages (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_stages_all"].on_schema_object[0].all[0].object_type_plural == "STAGES"
    error_message = "Object type is incorrect for stages (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_stages_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for stages (all)"
  }

  # Write privileges on future stages
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_stages_future"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect for stages (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_stages_future"].privileges == toset(["WRITE"])
    error_message = "Privileges are incorrect for stages (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_stages_future"].on_schema_object[0].future[0].object_type_plural == "STAGES"
    error_message = "Object type is incorrect for stages (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_stages_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for stages (future)"
  }

  # Write privileges on tasks
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tasks_all"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect for tasks (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tasks_all"].privileges == toset(["OPERATE"])
    error_message = "Privileges are incorrect for tasks (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tasks_all"].on_schema_object[0].all[0].object_type_plural == "TASKS"
    error_message = "Object type is incorrect for tasks (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tasks_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for tasks (all)"
  }

  # Write privileges on future tasks
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tasks_future"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect for tasks (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tasks_future"].privileges == toset(["OPERATE"])
    error_message = "Privileges are incorrect for tasks (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tasks_future"].on_schema_object[0].future[0].object_type_plural == "TASKS"
    error_message = "Object type is incorrect for tasks (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_tasks_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for tasks (future)"
  }

  # Write privileges on dynamic tables
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_dynamic_tables_all"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect for dynamic tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_dynamic_tables_all"].privileges == toset(["OPERATE"])
    error_message = "Privileges are incorrect for dynamic tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_dynamic_tables_all"].on_schema_object[0].all[0].object_type_plural == "DYNAMIC TABLES"
    error_message = "Object type is incorrect for dynamic tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_dynamic_tables_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for dynamic tables (all)"
  }

  # Write privileges on future dynamic tables
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_dynamic_tables_future"].account_role_name == "TEST_RAW_RW"
    error_message = "Role name is incorrect for dynamic tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_dynamic_tables_future"].privileges == toset(["OPERATE"])
    error_message = "Privileges are incorrect for dynamic tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_dynamic_tables_future"].on_schema_object[0].future[0].object_type_plural == "DYNAMIC TABLES"
    error_message = "Object type is incorrect for dynamic tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_write_privileges_rw["RAW_dynamic_tables_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for dynamic tables (future)"
  }
}
