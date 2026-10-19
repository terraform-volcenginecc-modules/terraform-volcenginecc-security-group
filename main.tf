resource "volcenginecc_vpc_security_group" "this" {
  vpc_id              = var.vpc_id
  security_group_name = var.security_group_name
  description         = var.description
  project_name        = var.project_name

  ingress_permissions = [
    for rule in values(var.ingress_rules) : {
      cidr_ip         = try(rule.cidr_ip, null) == null ? "" : rule.cidr_ip
      prefix_list_id  = ""
      source_group_id = try(rule.source_group_id, null) == null ? "" : rule.source_group_id
      description     = rule.description
      direction       = "ingress"
      policy          = rule.policy
      port_start      = rule.port_start
      port_end        = rule.port_end
      priority        = rule.priority
      protocol        = lower(rule.protocol)
    }
  ]

  egress_permissions = [
    for rule in values(merge(var.egress_rules, var.system_default_egress_rules)) : {
      cidr_ip         = try(rule.cidr_ip, null) == null ? "" : rule.cidr_ip
      prefix_list_id  = ""
      source_group_id = try(rule.source_group_id, null) == null ? "" : rule.source_group_id
      description     = rule.description
      direction       = "egress"
      policy          = rule.policy
      port_start      = rule.port_start
      port_end        = rule.port_end
      priority        = rule.priority
      protocol        = lower(rule.protocol)
    }
  ]

  tags = [
    for key, value in var.tags : {
      key   = key
      value = value
    }
  ]

  lifecycle {
    precondition {
      condition = var.allow_public_management_access || !anytrue([
        for rule in values(var.ingress_rules) :
        (rule.cidr_ip == null ? false : contains(["0.0.0.0/0", "::/0"], rule.cidr_ip)) &&
        (
          lower(rule.protocol) == "all" ||
          (
            lower(rule.protocol) == "tcp" &&
            (
              (rule.port_start <= 22 && rule.port_end >= 22) ||
              (rule.port_start <= 3389 && rule.port_end >= 3389)
            )
          )
        )
      ])
      error_message = "Ingress SSH (22) or RDP (3389) access from 0.0.0.0/0 or ::/0 requires allow_public_management_access to be true."
    }
  }
}
