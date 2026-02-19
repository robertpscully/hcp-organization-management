# Customer Project Module

This module provisions a complete customer team project with workspace, team, and access controls.

## Features

- Creates an HCP Terraform project
- Provisions a manager workspace with VCS connection
- Creates a workspace manager team
- Grants the team maintain access on the project
- Generates an ephemeral team token
- Stores the token as `TFE_TOKEN` environment variable in the workspace

## Usage

```hcl
module "customer_project" {
  source = "./modules/customer_project"

  terraform_organization     = "my-org"
  project_name               = "AWS Team Project"
  repository_identifier      = "owner/aws-team-repo"
  oauth_token_id = "ot-xxxxx"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7 |
| tfe | ~> 0.61 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `terraform_organization` | HCP Terraform organization name | `string` | n/a | yes |
| `project_name` | Project name (used as prefix for workspace and team) | `string` | n/a | yes |
| `repository_identifier` | VCS repository identifier (owner/repo) | `string` | n/a | yes |
| `oauth_token_id` | OAuth Token ID for VCS integration | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| `project_id` | ID of the created project |
| `workspace_id` | ID of the manager workspace |
| `team_id` | ID of the workspace manager team |

## Resources Created

| Resource | Name Pattern |
|----------|--------------|
| `tfe_project.this` | `{project_name}` |
| `tfe_workspace.manager` | `{project_name} Manager` |
| `tfe_team.workspace_manager` | `{project_name} Workspace Manager` |
| `tfe_team_project_access.workspace_manager` | Maintain access on project |
| `ephemeral.tfe_team_token.workspace_manager` | Team token (not stored in state) |
| `tfe_variable.tfe_token` | `TFE_TOKEN` env var in workspace |

## Workspace Configuration

The manager workspace is configured with:
- **Working Directory:** `terraform/workspaces`
- **Trigger Patterns:** `terraform/workspaces/**/*`
- **VCS:** Connected when `oauth_token_id` is provided

## Team Access

The workspace manager team receives `maintain` access on the project with:
- Project settings: read
- Project teams: none
- Full workspace management capabilities
