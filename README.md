# snowform_access_roles
Terraform Module for configurable generation of access roles in Snowflake.

Implement a secure and manageable Snowflake environment by following the [official Snowflake recommendation](https://docs.snowflake.com/en/user-guide/security-access-control-considerations#aligning-object-access-with-business-functions) for role hierarchy. This module provides the tools to build that hierarchy, distinguishing between:
- **Access Roles**: Managing granular, technical permissions.
- **Functional Roles**: Aligned with business units and duties.

This structure ensures easier auditing and clearer separation of duties.

For a detailed rationale and a complete template for your snowflake account, plese refer to [SnowForm Documentation](https://github.com/inovex/snowform_docs).

## Usage

```
module "access_roles" {
   source  = "https://github.com/inovex/snowform_access_roles/local"
   version = "0.0.X"
   db      = snowflake_database.yor_deployed_db
   schemas = [
    {
      name = "YOUR_SCHEMA_1"
    },
    {
      name = "YOUR_SCHEMA_2"
    }
  ]
  providers = {
    snowflake.useradmin     = snowflake.useradmin
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
  }
}
```
