# terraform-volcenginecc-security-group

## 1. 概述

基于 `volcenginecc` Provider 管理火山引擎 SECURITY GROUP 资源的 Terraform 模块。调用方负责 Provider 凭据、地域配置，以及通过 ID 传入的外部资源。

## 2. 用法

```hcl
module "security_group" {
  source  = "terraform-volcenginecc-modules/security-group/volcenginecc"
  version = "~> 1.0"

  # 请设置适用于当前环境的必填模块输入。
}
```

## 3. 示例

- `basic`：可独立运行的 basic 配置。
- `complete`：可独立运行的 complete 配置。

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
| `volcenginecc_vpc_security_group` | 模块定义的 volcenginecc_vpc_security_group。 |

## 7. 输入

| 名称 | 说明 |
|---|---|
| `vpc_id` | 模块定义的 vpc_id。 |
| `security_group_name` | 模块定义的 security_group_name。 |
| `description` | 模块定义的 description。 |
| `project_name` | 模块定义的 project_name。 |
| `ingress_rules` | 模块定义的 ingress_rules。 |
| `egress_rules` | 模块定义的 egress_rules。 |
| `system_default_egress_rules` | 模块定义的 system_default_egress_rules。 |
| `allow_public_management_access` | 模块定义的 allow_public_management_access。 |
| `tags` | 模块定义的 tags。 |

## 8. 输出

| 名称 | 说明 |
|---|---|
| `security_group_id` | 模块定义的 security_group_id。 |
| `security_group_name` | 模块定义的 security_group_name。 |
| `vpc_id` | 模块定义的 vpc_id。 |

## 9. 注意事项

- 请通过 Provider 支持的方式配置凭据，不要将访问密钥写入模块文件。
- 执行变更前请审阅替换行为及 Provider 限制。
- apply 后请再次执行 `terraform plan`，并确认第二次 plan 无变更。
