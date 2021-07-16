output "bigquery_dataset" {
  value       = module.bigquery_parent.bigquery_dataset
  description = "Bigquery dataset resource."
}

output "bigquery_tables" {
  value       = module.bigquery_parent.bigquery_tables
  description = "Map of bigquery table resources being provisioned."
}

output "bigquery_external_tables" {
  value       = module.bigquery_parent.bigquery_external_tables
  description = "Map of bigquery table resources being provisioned."
}
