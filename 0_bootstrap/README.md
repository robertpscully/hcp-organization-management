# 0_bootstrap

This configuration bootstraps the HCP Terraform organization by creating foundational resources using a user token. It is designed to be run locally once, using an owner token, to set up the self-managing pipeline.

## Purpose

Creates the initial resources required for the organization to manage itself:
- Organization token for API authentication
- Org Management Project to contain administrative workspaces
- Administration workspace with VCS connection
- Variable sets to pass configuration to managed workspaces
- Import-only variable set to enable state migration

## Resources Created

### Core Resources (`main.tf`)
| Resource | Description |
|----------|-------------|
| `tfe_organization_token.main` | Organization-level API token with configurable expiry |
| `tfe_project.org_management` | Project containing all administrative workspaces |
| `tfe_workspace.org_administration` | Workspace managing `1_organization_management/` |

### Org Management Variable Set (`varset_org_management.tf`)
| Resource | Description |
|----------|-------------|
| `tfe_variable_set.org_management` | Variables scoped to Org Management Project |
| `tfe_variable.tfe_token` | TFE_TOKEN environment variable (write-only) |
| `tfe_variable.management_repo_identifier` | Repository identifier for VCS |

### Global Variable Set (`varset_global_variables.tf`)
| Resource | Description |
|----------|-------------|
| `tfe_variable_set.global_variables` | Global variables available to all workspaces |
| `tfe_variable.oauth_token_id` | OAuth Token ID for VCS connections |
| `tfe_variable.terraform_organization` | Organization name |

### Import Variables (`varset_importonly.tf`)
Temporary variable set containing resource IDs needed by `1_organization_management` to import the bootstrapped resources into its state.

This variable set is not intended to be maintained after initial deployment.

### Deploying without the OAuth Token ID

Special note: The OAuth token ID may not be available until after the first VCS connection has been made in your organization. If this is the case provide an empty string, "", as the variable value, and the admin workspace will be created in remote mode, without a VCS workflow.

Because the VCS connection requires a human input, its initial creation cannot be completed in an automated way.

Configuring the VCS connection in the workspace will allow it to be reused for other workspaces.

Once this is available, rerun the local plan and apply, providing the variable value, to update the workspace state to match the configuration.

## Usage

```bash
# Set required variables
export TF_VAR_terraform_organization="your-org"
export TF_VAR_oauth_token_id="ot-xxxxx"
export TF_VAR_management_repo_identifier="owner/repo"

# Initialize and apply
terraform init
terraform apply
```

## Variables

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `terraform_organization` | string | yes | HCP Terraform organization name |
| `oauth_token_id` | string | yes | OAuth Token ID for VCS integration |
| `management_repo_identifier` | string | yes | Repository identifier (owner/repo) |
| `token_expiry_days` | number | no | Token expiry in days (default: 7) |

## Outputs

| Name | Description |
|------|-------------|
| `project_id` | ID of the Org Management Project |
| `workspace_id` | ID of the Administration workspace |
