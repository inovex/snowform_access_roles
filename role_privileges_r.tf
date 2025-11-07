# Grant privileges to the access roles

# Define object types and their privileges
locals {
  read_object_privileges = {
    "TABLES" = {
      privileges = ["SELECT", "REFERENCES"]
      prefix     = "read"
    }
    "VIEWS" = {
      privileges = ["SELECT"]
      prefix     = "read"
    }
    "STAGES" = {
      privileges = ["USAGE", "READ"]
      prefix     = "read"
    }
    "FILE FORMATS" = {
      privileges = ["USAGE"]
      prefix     = "read"
    }
    "STREAMS" = {
      privileges = ["SELECT"]
      prefix     = "read"
    }
    "PROCEDURES" = {
      privileges = ["USAGE"]
      prefix     = "read"
    }
    "FUNCTIONS" = {
      privileges = ["USAGE"]
      prefix     = "read"
    }
    "MATERIALIZED VIEWS" = {
      privileges = ["SELECT", "REFERENCES"]
      prefix     = "read"
    }
    "DYNAMIC TABLES" = {
      privileges = ["SELECT", "MONITOR"]
      prefix     = "read"
    }
    "TASKS" = {
      privileges = ["MONITOR"]
      prefix     = "monitor"
    }
  }

  # Create a flattened map for all combinations of data layers, object types, and scope (all/future)
  read_grants = merge([
    for schema_key, schema in local.schema_map : merge([
      for object_type, config in local.read_object_privileges : {
        for scope in ["all", "future"] :
        "${schema_key}_${replace(lower(object_type), " ", "_")}_${scope}" => {
          schema_name = schema.name
          object_type = object_type
          privileges  = config.privileges
          prefix      = config.prefix
          scope       = scope
        }
      }
    ]...)
  ]...)
}

# Read privileges for all object types (consolidated resource)
resource "snowflake_grant_privileges_to_account_role" "grant_read_privileges_r" {
  for_each          = local.read_grants
  provider          = snowflake.sysadmin
  privileges        = each.value.privileges
  account_role_name = snowflake_account_role.r[each.value.schema_name].name
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
