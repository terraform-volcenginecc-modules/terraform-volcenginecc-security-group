# COMPLETE SECURITY GROUP Example

## 1. Overview

Runnable complete configuration for the SECURITY GROUP module. It configures the provider from input variables and calls the published Registry module.

## 2. Usage

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. Examples

This directory is the complete example.

## 4. Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 5. Providers

| Name | Source |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 6. Resources

| Name | Description |
|---|---|
| `terraform-volcenginecc-modules/security-group/volcenginecc` | Published SECURITY GROUP module. |

## 7. Inputs

| Name | Description |
|---|---|
| `vpc_id` | Module-defined vpc_id. |
| `security_group_name` | Module-defined security_group_name. |
| `load_balancer_security_group_id` | Module-defined load_balancer_security_group_id. |
| `peer_service_security_group_id` | Module-defined peer_service_security_group_id. |
| `database_security_group_id` | Module-defined database_security_group_id. |
| `ssh_source_cidr` | Module-defined ssh_source_cidr. |
| `ipv6_load_balancer_cidr` | Module-defined ipv6_load_balancer_cidr. |
| `application_port` | Module-defined application_port. |
| `environment` | Module-defined environment. |
| `system_default_egress_rules` | Module-defined system_default_egress_rules. |

## 8. Outputs

| Name | Description |
|---|---|
| `security_group_id` | Module-defined security_group_id. |

## 9. Notes

- Supply credentials through supported provider configuration, never in source files.
- The final plan after apply must report no changes before the configuration is accepted.
