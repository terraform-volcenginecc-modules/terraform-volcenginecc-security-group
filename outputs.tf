output "security_group_id" {
  description = "ID of the managed security group."
  value       = volcenginecc_vpc_security_group.this.security_group_id
}

output "security_group_name" {
  description = "Name of the managed security group."
  value       = volcenginecc_vpc_security_group.this.security_group_name
}

output "vpc_id" {
  description = "VPC ID associated with the managed security group."
  value       = volcenginecc_vpc_security_group.this.vpc_id
}
