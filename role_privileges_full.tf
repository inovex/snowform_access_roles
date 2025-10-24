# Grant privileges to the access roles

# Full
resource "snowflake_grant_privileges_to_account_role" "grant_all_on_db_schema_full" {
  for_each          = local.schema_map
  provider          = snowflake.sysadmin
  all_privileges    = true
  always_apply      = true
  account_role_name = snowflake_account_role.full[each.value.name].name
  on_schema {
    schema_name = "\"${var.db.name}\".\"${each.value.name}\""
  }
}
