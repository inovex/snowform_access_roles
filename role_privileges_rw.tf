# Grant privileges to the access roles

# Define object types and their write privileges
locals {
  write_object_privileges = {
    "TABLES" = {
      privileges = ["INSERT", "UPDATE", "DELETE", "TRUNCATE"]
      prefix     = "write"
    }
    "STAGES" = {
      privileges = ["WRITE"]
      prefix     = "write"
    }
    "TASKS" = {
      privileges = ["OPERATE"]
      prefix     = "write"
    }
    "DYNAMIC TABLES" = {
      privileges = ["OPERATE"]
      prefix     = "write"
    }
  }

  # Create a flattened map for all combinations of data layers, object types, and scope (all/future)
  write_grants = merge([
    for schema_key, schema in local.schema_map : merge([
      for object_type, config in local.write_object_privileges : {
        for scope in ["all", "future"] :
        "${schema_key}_${replace(lower(object_type), " ", "_")}_${scope}" => {
          schema_name = schema.name
          object_type     = object_type
          privileges      = config.privileges
          prefix          = config.prefix
          scope           = scope
        }
      }
    ]...)
  ]...)
}

# Write privileges for all object types (consolidated resource)
resource "snowflake_grant_privileges_to_account_role" "grant_write_privileges_rw" {
  for_each          = local.write_grants
  provider          = snowflake.sysadmin
  privileges        = each.value.privileges
  account_role_name = snowflake_account_role.rw[each.value.schema_name].name
  always_apply      = each.value.scope == "all" ? true : null

  on_schema_object {
    dynamic "all" {
      for_each = each.value.scope == "all" ? [1] : []
      content {
        object_type_plural = each.value.object_type
        in_schema          = "\"${var.db.name}\".\"${each.value.schema_name}\""
      }
    }

    dynamic "future" {
      for_each = each.value.scope == "future" ? [1] : []
      content {
        object_type_plural = each.value.object_type
        in_schema          = "\"${var.db.name}\".\"${each.value.schema_name}\""
      }
    }
  }
}
