# Workspaces

This configuration defines the infrastructure workspaces for the customer project. It is managed by the `{project_name}-manager` workspace.

## Purpose

- Create infrastructure workspaces within the customer project
- Configure VCS connections for GitOps workflow
- Set up AWS OIDC authentication for dynamic credentials
- Define workspace variables

## Resources Created

### Infrastructure Workspace (`main.tf`)
| Resource | Description |
|----------|-------------|
| `tfe_workspace.infrastructure` | Main infrastructure workspace targeting `terraform/infrastructure` |
| `tfe_variable.aws_run_role_arn` | `TFC_AWS_RUN_ROLE_ARN` for AWS OIDC |
| `tfe_variable.enable_aws_run_role_arn` | `TFC_AWS_PROVIDER_AUTH` to enable OIDC |
| `tfe_variable.hashitalks_tag` | Custom tag variable (example) |

## Trigger Configuration

The infrastructure workspace is configured with:
- **Working Directory:** `3_customer_project_code/terraform/infrastructure`
- **Trigger Patterns:** `3_customer_project_code/terraform/infrastructure/**/*`

## Variables

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `terraform_organization` | string | yes | HCP Terraform organization name |
| `oauth_token_id` | string | yes | OAuth Token ID for VCS integration (validated) |
| `project_id` | string | yes | ID of the project to create workspaces in |
| `repo_identifier` | string | yes | Repository identifier for VCS connection |

## AWS OIDC Configuration

The workspace is configured with AWS OIDC authentication:

```hcl
resource "tfe_variable" "enable_aws_run_role_arn" {
  key      = "TFC_AWS_PROVIDER_AUTH"
  value    = "true"
  category = "env"
}

resource "tfe_variable" "aws_run_role_arn" {
  key      = "TFC_AWS_RUN_ROLE_ARN"
  value    = "arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
  category = "env"
}
```

This allows Terraform runs to assume an AWS IAM role without storing static credentials.

## Adding New Workspaces

To add a new infrastructure workspace:

```hcl
resource "tfe_workspace" "new_workspace" {
  organization      = var.terraform_organization
  name              = "new-workspace-name"
  project_id        = var.project_id
  working_directory = "3_customer_project_code/terraform/new-infrastructure"
  trigger_patterns  = ["3_customer_project_code/terraform/new-infrastructure/**/*"]

  dynamic "vcs_repo" {
    for_each = var.oauth_token_id != null ? [1] : []
    content {
      branch         = "main"
      oauth_token_id = var.oauth_token_id
      identifier     = var.repo_identifier
    }
  }
}
```
