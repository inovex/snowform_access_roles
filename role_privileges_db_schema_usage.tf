# Grant privileges to the access roles

# DB usage
resource "snowflake_grant_privileges_to_account_role" "grant_usage_on_db_r" {
  for_each          = local.schema_map
  provider          = snowflake.sysadmin
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.r[each.value.name].name
  on_account_object {
    object_type = "DATABASE"
    object_name = var.db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_usage_on_db_rw" {
  for_each          = local.schema_map
  provider          = snowflake.sysadmin
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.rw[each.value.name].name
  on_account_object {
    object_type = "DATABASE"
    object_name = var.db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_usage_on_db_full" {
  for_each          = local.schema_map
  provider          = snowflake.sysadmin
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.full[each.value.name].name
  on_account_object {
    object_type = "DATABASE"
    object_name = var.db.name
  }
}

# schema usage
resource "snowflake_grant_privileges_to_account_role" "grant_usage_on_db_schema_r" {
  for_each          = local.schema_map
  provider          = snowflake.sysadmin
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.r[each.value.name].name
  on_schema {
    schema_name = "\"${var.db.name}\".\"${each.value.name}\""
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_usage_on_db_schema_rw" {
  for_each          = local.schema_map
  provider          = snowflake.sysadmin
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.rw[each.value.name].name
  on_schema {
    schema_name = "\"${var.db.name}\".\"${each.value.name}\""
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_usage_on_db_schema_full" {
  for_each          = local.schema_map
  provider          = snowflake.sysadmin
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.full[each.value.name].name
  on_schema {
    schema_name = "\"${var.db.name}\".\"${each.value.name}\""
  }
}
