output "r" {
  description = "Snowflake read role"
  value       = snowflake_account_role.r
}

output "rw" {
  description = "Snowflake read-write role"
  value       = snowflake_account_role.rw
}

output "full" {
  description = "Snowflake full access role"
  value       = snowflake_account_role.full
}
