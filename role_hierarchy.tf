# Build role hierarchy
# More powerful roles inherit from less powerful roles, which means we are not granting redundant privileges
# SYSADMIN > FULL > RW > R

resource "snowflake_grant_account_role" "r_grants_sysadmin" {
  for_each         = local.schema_map
  provider         = snowflake.securityadmin
  role_name        = snowflake_account_role.r[each.value.name].name
  parent_role_name = "SYSADMIN"
  depends_on       = [snowflake_account_role.rw]
}
resource "snowflake_grant_account_role" "r_grants_read_write" {
  for_each         = local.schema_map
  provider         = snowflake.securityadmin
  role_name        = snowflake_account_role.r[each.value.name].name
  parent_role_name = "${var.db.name}_${each.value.name}_RW"
  depends_on       = [snowflake_account_role.rw]
}

resource "snowflake_grant_account_role" "role_rw_grants_sysadmin" {
  for_each         = local.schema_map
  provider         = snowflake.securityadmin
  role_name        = snowflake_account_role.rw[each.value.name].name
  parent_role_name = "SYSADMIN"
  depends_on       = [snowflake_account_role.full]
}
resource "snowflake_grant_account_role" "role_rw_grants_full" {
  for_each         = local.schema_map
  provider         = snowflake.securityadmin
  role_name        = snowflake_account_role.rw[each.value.name].name
  parent_role_name = "${var.db.name}_${each.value.name}_FULL"
  depends_on       = [snowflake_account_role.full]
}

resource "snowflake_grant_account_role" "role_full_grants_sysadmin" {
  for_each         = local.schema_map
  provider         = snowflake.securityadmin
  role_name        = snowflake_account_role.full[each.value.name].name
  parent_role_name = "SYSADMIN"
}
