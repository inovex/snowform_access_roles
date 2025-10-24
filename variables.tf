variable "db" {
  description = "The Snowflake Database for which the access roles are defined."
  type = object({
    name = string
  })
}

variable "schemas" {
  description = "The data layers for which the access roles are defined."
  type = list(object({
    name = string
  }))

  default = [
    {
      name = "EXAMPLE"
    }
  ]
}

locals {
  schema_map = { for schema in var.schemas : schema.name => schema }
}
