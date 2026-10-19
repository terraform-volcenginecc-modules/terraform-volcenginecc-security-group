output "security_group_id" {
  description = "ID to associate with ECS instances, VKE nodes, or CLB backend instances."
  value       = module.security_group.security_group_id
}
