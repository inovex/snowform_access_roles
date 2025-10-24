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

run "test_privileges_of_role_r" {
  command = plan

  providers = {
    snowflake.sysadmin      = snowflake.mockprovider
    snowflake.securityadmin = snowflake.mockprovider
    snowflake.useradmin     = snowflake.mockprovider
  }

  # Read privileges on tables
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tables_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tables_all"].privileges == toset(["SELECT", "REFERENCES"])
    error_message = "Privileges are incorrect for tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tables_all"].on_schema_object[0].all[0].object_type_plural == "TABLES"
    error_message = "Object type is incorrect for tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tables_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for tables (all)"
  }

  # Read privileges on future tables
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tables_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tables_future"].privileges == toset(["SELECT", "REFERENCES"])
    error_message = "Privileges are incorrect for tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tables_future"].on_schema_object[0].future[0].object_type_plural == "TABLES"
    error_message = "Object type is incorrect for tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tables_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for tables (future)"
  }

  # Read privileges on views
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_views_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for views (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_views_all"].privileges == toset(["SELECT"])
    error_message = "Privileges are incorrect for views (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_views_all"].on_schema_object[0].all[0].object_type_plural == "VIEWS"
    error_message = "Object type is incorrect for views (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_views_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for views (all)"
  }

  # Read privileges on future views
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_views_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for views (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_views_future"].privileges == toset(["SELECT"])
    error_message = "Privileges are incorrect for views (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_views_future"].on_schema_object[0].future[0].object_type_plural == "VIEWS"
    error_message = "Object type is incorrect for views (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_views_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for views (future)"
  }

  # Read privileges on stages
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_stages_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for stages (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_stages_all"].privileges == toset(["USAGE", "READ"])
    error_message = "Privileges are incorrect for stages (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_stages_all"].on_schema_object[0].all[0].object_type_plural == "STAGES"
    error_message = "Object type is incorrect for stages (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_stages_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for stages (all)"
  }

  # Read privileges on future stages
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_stages_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for stages (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_stages_future"].privileges == toset(["USAGE", "READ"])
    error_message = "Privileges are incorrect for stages (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_stages_future"].on_schema_object[0].future[0].object_type_plural == "STAGES"
    error_message = "Object type is incorrect for stages (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_stages_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for stages (future)"
  }

  # Read privileges on file formats
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_file_formats_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for file formats (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_file_formats_all"].privileges == toset(["USAGE"])
    error_message = "Privileges are incorrect for file formats (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_file_formats_all"].on_schema_object[0].all[0].object_type_plural == "FILE FORMATS"
    error_message = "Object type is incorrect for file formats (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_file_formats_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for file formats (all)"
  }

  # Read privileges on future file formats
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_file_formats_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for file formats (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_file_formats_future"].privileges == toset(["USAGE"])
    error_message = "Privileges are incorrect for file formats (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_file_formats_future"].on_schema_object[0].future[0].object_type_plural == "FILE FORMATS"
    error_message = "Object type is incorrect for file formats (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_file_formats_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for file formats (future)"
  }

  # Read privileges on streams
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_streams_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for streams (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_streams_all"].privileges == toset(["SELECT"])
    error_message = "Privileges are incorrect for streams (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_streams_all"].on_schema_object[0].all[0].object_type_plural == "STREAMS"
    error_message = "Object type is incorrect for streams (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_streams_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for streams (all)"
  }

  # Read privileges on future streams
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_streams_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for streams (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_streams_future"].privileges == toset(["SELECT"])
    error_message = "Privileges are incorrect for streams (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_streams_future"].on_schema_object[0].future[0].object_type_plural == "STREAMS"
    error_message = "Object type is incorrect for streams (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_streams_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for streams (future)"
  }

  # Read privileges on procedures
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_procedures_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for procedures (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_procedures_all"].privileges == toset(["USAGE"])
    error_message = "Privileges are incorrect for procedures (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_procedures_all"].on_schema_object[0].all[0].object_type_plural == "PROCEDURES"
    error_message = "Object type is incorrect for procedures (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_procedures_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for procedures (all)"
  }

  # Read privileges on future procedures
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_procedures_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for procedures (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_procedures_future"].privileges == toset(["USAGE"])
    error_message = "Privileges are incorrect for procedures (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_procedures_future"].on_schema_object[0].future[0].object_type_plural == "PROCEDURES"
    error_message = "Object type is incorrect for procedures (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_procedures_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for procedures (future)"
  }

  # Read privileges on functions
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_functions_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for functions (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_functions_all"].privileges == toset(["USAGE"])
    error_message = "Privileges are incorrect for functions (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_functions_all"].on_schema_object[0].all[0].object_type_plural == "FUNCTIONS"
    error_message = "Object type is incorrect for functions (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_functions_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for functions (all)"
  }

  # Read privileges on future functions
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_functions_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for functions (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_functions_future"].privileges == toset(["USAGE"])
    error_message = "Privileges are incorrect for functions (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_functions_future"].on_schema_object[0].future[0].object_type_plural == "FUNCTIONS"
    error_message = "Object type is incorrect for functions (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_functions_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for functions (future)"
  }

  # Read privileges on materialized views
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_materialized_views_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for materialized views (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_materialized_views_all"].privileges == toset(["SELECT", "REFERENCES"])
    error_message = "Privileges are incorrect for materialized views (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_materialized_views_all"].on_schema_object[0].all[0].object_type_plural == "MATERIALIZED VIEWS"
    error_message = "Object type is incorrect for materialized views (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_materialized_views_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for materialized views (all)"
  }

  # Read privileges on future materialized views
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_materialized_views_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for materialized views (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_materialized_views_future"].privileges == toset(["SELECT", "REFERENCES"])
    error_message = "Privileges are incorrect for materialized views (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_materialized_views_future"].on_schema_object[0].future[0].object_type_plural == "MATERIALIZED VIEWS"
    error_message = "Object type is incorrect for materialized views (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_materialized_views_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for materialized views (future)"
  }

  # Read privileges on dynamic tables
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_dynamic_tables_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for dynamic tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_dynamic_tables_all"].privileges == toset(["SELECT", "REFERENCES", "MONITOR"])
    error_message = "Privileges are incorrect for dynamic tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_dynamic_tables_all"].on_schema_object[0].all[0].object_type_plural == "DYNAMIC TABLES"
    error_message = "Object type is incorrect for dynamic tables (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_dynamic_tables_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for dynamic tables (all)"
  }

  # Read privileges on future dynamic tables
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_dynamic_tables_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for dynamic tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_dynamic_tables_future"].privileges == toset(["SELECT", "REFERENCES", "MONITOR"])
    error_message = "Privileges are incorrect for dynamic tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_dynamic_tables_future"].on_schema_object[0].future[0].object_type_plural == "DYNAMIC TABLES"
    error_message = "Object type is incorrect for dynamic tables (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_dynamic_tables_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for dynamic tables (future)"
  }

  # Read privileges on tasks
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tasks_all"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for tasks (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tasks_all"].privileges == toset(["MONITOR"])
    error_message = "Privileges are incorrect for tasks (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tasks_all"].on_schema_object[0].all[0].object_type_plural == "TASKS"
    error_message = "Object type is incorrect for tasks (all)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tasks_all"].on_schema_object[0].all[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for tasks (all)"
  }

  # Read privileges on future tasks
  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tasks_future"].account_role_name == "TEST_RAW_R"
    error_message = "Role name is incorrect for tasks (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tasks_future"].privileges == toset(["MONITOR"])
    error_message = "Privileges are incorrect for tasks (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tasks_future"].on_schema_object[0].future[0].object_type_plural == "TASKS"
    error_message = "Object type is incorrect for tasks (future)"
  }

  assert {
    condition     = snowflake_grant_privileges_to_account_role.grant_read_privileges_r["RAW_tasks_future"].on_schema_object[0].future[0].in_schema == "\"TEST\".\"RAW\""
    error_message = "Schema name is incorrect for tasks (future)"
  }
}
