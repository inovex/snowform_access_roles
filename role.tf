resource "snowflake_account_role" "r" {
  for_each = local.schema_map
  provider = snowflake.useradmin
  name     = "${var.db.name}_${each.value.name}_R"
}

resource "snowflake_account_role" "rw" {
  for_each = local.schema_map
  provider = snowflake.useradmin
  name     = "${var.db.name}_${each.value.name}_RW"
}

resource "snowflake_account_role" "full" {
  for_each = local.schema_map
  provider = snowflake.useradmin
  name     = "${var.db.name}_${each.value.name}_FULL"
}
