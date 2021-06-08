output "project_id" {
  value = var.project_id
}

output "name" {
  description = "The name for Cloud SQL instance"
  value       = module.postgresql.instance_name
}

output "authorized_network" {
  value = var.pg_ha_external_ip_range
}

output "replicas" {
  value = module.postgresql.replicas
}

output "instances" {
  value = module.postgresql.instances
}