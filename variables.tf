variable "vpc_id" {
  type        = string
  description = "ID of the VPC that owns this security group. Changing this value replaces the security group."

  validation {
    condition     = length(trimspace(var.vpc_id)) > 0
    error_message = "vpc_id must not be empty."
  }
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group. It must be 1 to 128 characters and conform to Volcengine naming rules."

  validation {
    condition     = length(var.security_group_name) >= 1 && length(var.security_group_name) <= 128
    error_message = "security_group_name must contain between 1 and 128 characters."
  }
}

variable "description" {
  type        = string
  description = "Optional description of the security group."
  default     = ""

  validation {
    condition     = length(var.description) <= 255
    error_message = "description must not exceed 255 characters."
  }
}

variable "project_name" {
  type        = string
  description = "Project that owns the security group. Changing this value replaces the security group."
  default     = "default"

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name must not be empty."
  }
}

variable "ingress_rules" {
  type = map(object({
    description     = string
    protocol        = string
    port_start      = number
    port_end        = number
    cidr_ip         = optional(string)
    source_group_id = optional(string)
    policy          = optional(string, "accept")
    priority        = optional(number, 1)
  }))
  description = "Inbound rules keyed by a stable logical name. Each rule must specify exactly one of cidr_ip or source_group_id."
  default     = {}

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) :
      length(compact([try(rule.cidr_ip, ""), try(rule.source_group_id, "")])) == 1
    ])
    error_message = "Each ingress rule must set exactly one of cidr_ip or source_group_id."
  }

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) :
      rule.cidr_ip == null ? true : can(cidrhost(rule.cidr_ip, 0))
    ])
    error_message = "Each ingress rule cidr_ip must be a valid IPv4 or IPv6 CIDR."
  }

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) :
      contains(["tcp", "udp", "icmp", "icmpv6", "all"], lower(rule.protocol))
    ])
    error_message = "Ingress rule protocol must be tcp, udp, icmp, icmpv6, or all."
  }

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) :
      contains(["accept", "drop"], lower(rule.policy))
    ])
    error_message = "Ingress rule policy must be accept or drop."
  }

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) :
      rule.priority >= 1 && rule.priority <= 100
    ])
    error_message = "Ingress rule priority must be between 1 and 100."
  }

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) :
      length(rule.description) >= 1 && length(rule.description) <= 255
    ])
    error_message = "Ingress rule description must contain between 1 and 255 characters."
  }

  validation {
    condition = alltrue([
      for rule in values(var.ingress_rules) :
      contains(["tcp", "udp"], lower(rule.protocol)) ?
      rule.port_start >= 1 && rule.port_end <= 65535 && rule.port_start <= rule.port_end :
      rule.port_start == -1 && rule.port_end == -1
    ])
    error_message = "TCP and UDP ingress rules require an ordered port range from 1 to 65535; other protocols require port_start and port_end to be -1."
  }
}

variable "egress_rules" {
  type = map(object({
    description     = string
    protocol        = string
    port_start      = number
    port_end        = number
    cidr_ip         = optional(string)
    source_group_id = optional(string)
    policy          = optional(string, "accept")
    priority        = optional(number, 1)
  }))
  description = "Outbound rules keyed by a stable logical name. Each rule must specify exactly one of cidr_ip or source_group_id."
  default     = {}

  validation {
    condition = alltrue([
      for rule in values(var.egress_rules) :
      length(compact([try(rule.cidr_ip, ""), try(rule.source_group_id, "")])) == 1
    ])
    error_message = "Each egress rule must set exactly one of cidr_ip or source_group_id."
  }

  validation {
    condition = alltrue([
      for rule in values(var.egress_rules) :
      rule.cidr_ip == null ? true : can(cidrhost(rule.cidr_ip, 0))
    ])
    error_message = "Each egress rule cidr_ip must be a valid IPv4 or IPv6 CIDR."
  }

  validation {
    condition = alltrue([
      for rule in values(var.egress_rules) :
      contains(["tcp", "udp", "icmp", "icmpv6", "all"], lower(rule.protocol))
    ])
    error_message = "Egress rule protocol must be tcp, udp, icmp, icmpv6, or all."
  }

  validation {
    condition = alltrue([
      for rule in values(var.egress_rules) :
      contains(["accept", "drop"], lower(rule.policy))
    ])
    error_message = "Egress rule policy must be accept or drop."
  }

  validation {
    condition = alltrue([
      for rule in values(var.egress_rules) :
      rule.priority >= 1 && rule.priority <= 100
    ])
    error_message = "Egress rule priority must be between 1 and 100."
  }

  validation {
    condition = alltrue([
      for rule in values(var.egress_rules) :
      length(rule.description) >= 1 && length(rule.description) <= 255
    ])
    error_message = "Egress rule description must contain between 1 and 255 characters."
  }

  validation {
    condition = alltrue([
      for rule in values(var.egress_rules) :
      contains(["tcp", "udp"], lower(rule.protocol)) ?
      rule.port_start >= 1 && rule.port_end <= 65535 && rule.port_start <= rule.port_end :
      rule.port_start == -1 && rule.port_end == -1
    ])
    error_message = "TCP and UDP egress rules require an ordered port range from 1 to 65535; other protocols require port_start and port_end to be -1."
  }
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
  description = "Server-created default egress rules adopted after the initial apply. Leave empty for the initial creation, then set the exact IPv4 and IPv6 rules returned by Cloud Control before the second apply."
  default     = {}

  validation {
    condition = alltrue([
      for rule in values(var.system_default_egress_rules) :
      can(cidrhost(rule.cidr_ip, 0))
    ])
    error_message = "Each system default egress rule cidr_ip must be a valid IPv4 or IPv6 CIDR."
  }

  validation {
    condition = alltrue([
      for rule in values(var.system_default_egress_rules) :
      lower(rule.protocol) == "all" &&
      rule.port_start == -1 &&
      rule.port_end == -1 &&
      lower(rule.policy) == "accept" &&
      rule.priority == 100
    ])
    error_message = "System default egress rules must be accept/all with ports -1/-1 and priority 100."
  }
}

variable "allow_public_management_access" {
  type        = bool
  description = "Explicitly allows ingress SSH (22) or RDP (3389) rules sourced from 0.0.0.0/0 or ::/0. Keep false unless public management access is approved."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the security group."
  default     = {}

  validation {
    condition     = alltrue([for key in keys(var.tags) : length(trimspace(key)) > 0])
    error_message = "Tag keys must not be empty."
  }
}
