module "security_group" {
  source  = "terraform-volcenginecc-modules/security-group/volcenginecc"
  version = "~> 1.0"

  vpc_id              = var.vpc_id
  security_group_name = var.security_group_name
  description         = "Restricted SSH access for an ECS instance."

  ingress_rules = {
    ssh_maintenance = {
      description = "SSH access from the operations network"
      protocol    = "tcp"
      port_start  = 22
      port_end    = 22
      cidr_ip     = var.ssh_source_cidr
    }
  }

  system_default_egress_rules = var.system_default_egress_rules

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Scenario    = "instance-access"
  }
}
