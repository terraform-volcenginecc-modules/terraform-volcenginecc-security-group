# terraform-volcenginecc-security-group

## 1. Overview

Terraform module for managing Volcengine SECURITY GROUP resources with the `volcenginecc` provider. The caller owns provider authentication, region configuration, and external resources passed by ID.

## 2. Usage

```hcl
module "security_group" {
  source  = "terraform-volcenginecc-modules/security-group/volcenginecc"
  version = "~> 1.0"

  # Set the required module inputs for your environment.
}
```

## 3. Examples

- `basic`: independently runnable basic configuration.
- `complete`: independently runnable complete configuration.

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
| `volcenginecc_vpc_security_group` | Module-defined volcenginecc_vpc_security_group. |

## 7. Inputs

| Name | Description |
|---|---|
| `vpc_id` | Module-defined vpc_id. |
| `security_group_name` | Module-defined security_group_name. |
| `description` | Module-defined description. |
| `project_name` | Module-defined project_name. |
| `ingress_rules` | Module-defined ingress_rules. |
| `egress_rules` | Module-defined egress_rules. |
| `system_default_egress_rules` | Module-defined system_default_egress_rules. |
| `allow_public_management_access` | Module-defined allow_public_management_access. |
| `tags` | Module-defined tags. |

## 8. Outputs

| Name | Description |
|---|---|
| `security_group_id` | Module-defined security_group_id. |
| `security_group_name` | Module-defined security_group_name. |
| `vpc_id` | Module-defined vpc_id. |

## 9. Notes

- Configure credentials using supported provider mechanisms; do not put access keys in module files.
- Review replacement behavior and provider constraints before applying changes.
- Run `terraform plan` after apply and confirm that the second plan has no changes.
