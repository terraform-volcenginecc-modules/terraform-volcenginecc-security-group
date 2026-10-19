module "security_group" {
  source  = "terraform-volcenginecc-modules/security-group/volcenginecc"
  version = "~> 1.0"

  vpc_id              = var.vpc_id
  security_group_name = var.security_group_name
  description         = "Least-privilege application access for ECS, VKE nodes, and CLB backends."

  ingress_rules = {
    web_http = {
      description     = "HTTP from the trusted load balancer security group"
      protocol        = "tcp"
      port_start      = 80
      port_end        = 80
      source_group_id = var.load_balancer_security_group_id
    }
    web_https = {
      description     = "HTTPS from the trusted load balancer security group"
      protocol        = "tcp"
      port_start      = 443
      port_end        = 443
      source_group_id = var.load_balancer_security_group_id
    }
    ssh_maintenance = {
      description = "SSH from the operations network"
      protocol    = "tcp"
      port_start  = 22
      port_end    = 22
      cidr_ip     = var.ssh_source_cidr
    }
    https_ipv6 = {
      description = "HTTPS from the trusted IPv6 load balancer range"
      protocol    = "tcp"
      port_start  = 443
      port_end    = 443
      cidr_ip     = var.ipv6_load_balancer_cidr
    }
    service_internal = {
      description     = "Application port from the peer service security group"
      protocol        = "tcp"
      port_start      = var.application_port
      port_end        = var.application_port
      source_group_id = var.peer_service_security_group_id
    }
  }

  egress_rules = {
    database_mysql = {
      description     = "MySQL access to the database security group"
      protocol        = "tcp"
      port_start      = 3306
      port_end        = 3306
      source_group_id = var.database_security_group_id
    }
  }

  system_default_egress_rules = var.system_default_egress_rules

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Scenario    = "instance-access"
  }
}
