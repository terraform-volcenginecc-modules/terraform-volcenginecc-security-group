variable "vpc_id" {
  type        = string
  description = "Existing VPC ID for the security group."
}

variable "security_group_name" {
  type        = string
  description = "Name of the application security group to create."
  default     = "complete-instance-access"
}

variable "load_balancer_security_group_id" {
  type        = string
  description = "Existing security group ID associated with the CLB that forwards web traffic."
}

variable "peer_service_security_group_id" {
  type        = string
  description = "Existing security group ID for the service allowed to call the application port."
}

variable "database_security_group_id" {
  type        = string
  description = "Existing security group ID for the database allowed to receive MySQL traffic."
}

variable "ssh_source_cidr" {
  type        = string
  description = "Trusted operations-network CIDR allowed to use SSH. Do not use 0.0.0.0/0."
}

variable "ipv6_load_balancer_cidr" {
  type        = string
  description = "Trusted IPv6 CIDR allowed to use HTTPS."
}

variable "application_port" {
  type        = number
  description = "TCP application port exposed only to the peer service security group."
  default     = 8080

  validation {
    condition     = var.application_port >= 1 && var.application_port <= 65535
    error_message = "application_port must be between 1 and 65535."
  }
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
