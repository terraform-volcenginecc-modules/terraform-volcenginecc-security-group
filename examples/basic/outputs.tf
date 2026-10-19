output "security_group_id" {
  description = "ID to associate with an ECS instance, VKE node, or other VPC resource."
  value       = module.security_group.security_group_id
}
