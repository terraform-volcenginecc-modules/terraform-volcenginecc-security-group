# COMPLETE SECURITY GROUP 示例

## 1. 概述

SECURITY GROUP 模块的可运行 complete 配置。它从输入变量设置 Provider，并调用已发布的 Registry 模块。

## 2. 用法

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. 示例

本目录即为 complete 示例。

## 4. 版本要求

| 名称 | 版本 |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 5. Provider

| 名称 | 来源 |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 6. 资源

| 名称 | 说明 |
|---|---|
| `terraform-volcenginecc-modules/security-group/volcenginecc` | 已发布的 SECURITY GROUP 模块。 |

## 7. 输入

| 名称 | 说明 |
|---|---|
| `vpc_id` | 模块定义的 vpc_id。 |
| `security_group_name` | 模块定义的 security_group_name。 |
| `load_balancer_security_group_id` | 模块定义的 load_balancer_security_group_id。 |
| `peer_service_security_group_id` | 模块定义的 peer_service_security_group_id。 |
| `database_security_group_id` | 模块定义的 database_security_group_id。 |
| `ssh_source_cidr` | 模块定义的 ssh_source_cidr。 |
| `ipv6_load_balancer_cidr` | 模块定义的 ipv6_load_balancer_cidr。 |
| `application_port` | 模块定义的 application_port。 |
| `environment` | 模块定义的 environment。 |
| `system_default_egress_rules` | 模块定义的 system_default_egress_rules。 |

## 8. 输出

| 名称 | 说明 |
|---|---|
| `security_group_id` | 模块定义的 security_group_id。 |

## 9. 注意事项

- 请通过 Provider 支持的配置提供凭据，绝不应写入源文件。
- apply 后的最终 plan 必须报告无变更，才能接受该配置。
