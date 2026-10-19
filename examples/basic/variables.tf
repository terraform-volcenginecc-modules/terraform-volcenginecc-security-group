variable "vpc_id" {
  type        = string
  description = "Existing VPC ID for the security group."
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group to create."
  default     = "basic-instance-access"
}

variable "ssh_source_cidr" {
  type        = string
  description = "Trusted operations-network CIDR allowed to use SSH. Do not use 0.0.0.0/0."
}

variable "environment" {
  type        = string
  description = "Environment tag value."
  default     = "dev"
}

variable "system_default_egress_rules" {
  type = map(object({
    description = string
    protocol    = string
    port_start  = number
    port_end    = number
    cidr_ip     = string
    policy      = optional(string, "accept")
    priority    = optional(number, 100)
  }))
  description = "Cloud Control default egress rules adopted after the initial apply. Keep empty during initial creation."
  default     = {}
}
