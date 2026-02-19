# 1_organization_management

This configuration manages the core HCP Terraform organization resources. It runs automatically in the `{org}-administration` workspace, triggered by changes to this directory.

## Purpose

- Imports and manages resources originally created by `0_bootstrap`
- Maintains organization-level configuration
- Provisions additional administrative workspaces (e.g., customer projects workspace)

## Resources Managed

### Core Resources (`main.tf`)
| Resource | Description |
|----------|-------------|
| `tfe_project.org_management` | Org Management Project (imported from bootstrap) |
| `tfe_workspace.org_administration` | This workspace (self-referential, imported) |
| `tfe_workspace.customer_projects` | Workspace managing `2_customer_projects/` |

### Org Management Variable Set (`varset_org_management.tf`)
| Resource | Description |
|----------|-------------|
| `tfe_variable_set.org_management` | Project-scoped variables |
| `tfe_project_variable_set.org_management` | Attaches variable set to project |
| `tfe_variable.management_repo_identifier` | Repository identifier |

### Global Variable Set (`varset_global_variables.tf`)
| Resource | Description |
|----------|-------------|
| `tfe_variable_set.global_variables` | Global variables (imported) |
| `tfe_variable.oauth_token_id` | OAuth Token ID for VCS |
| `tfe_variable.terraform_organization` | Organization name |

### Import Configuration (`imports.tf`)
Contains `import` blocks and temporary variables to import resources created by `0_bootstrap` into this workspace's state on first run.

## Trigger Configuration

This workspace is configured with:
- **Working Directory:** `1_organization_management`
- **Trigger Patterns:** `1_organization_management/**/*`

## Variables

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `terraform_organization` | string | yes | HCP Terraform organization name |
| `oauth_token_id` | string | yes | OAuth Token ID for VCS integration |
| `management_repo_identifier` | string | yes | Repository identifier (owner/repo) |
| `importonly_*` | various | yes | IDs for importing bootstrap resources |

## Import Variables

On first run, the following variables must be set (provided by bootstrap's IMPORT ONLY variable set):

| Variable | Source |
|----------|--------|
| `importonly_project_id` | `tfe_project.org_management.id` |
| `importonly_global_variable_varset_id` | `tfe_variable_set.global_variables.id` |
| `importonly_org_management_varset_id` | `tfe_variable_set.org_management.id` |
| `importonly_global_variable_var_*` | Variable IDs from global varset |
| `importonly_org_management_var_*` | Variable IDs from org management varset |
