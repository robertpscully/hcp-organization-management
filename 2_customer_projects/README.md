# 2_customer_projects

This configuration provisions customer team projects using a reusable module. It runs automatically in the `{org}-customer-projects` workspace, triggered by changes to this directory.

## Purpose

- Provision new customer/team projects with standardized configuration
- Create project workspaces with VCS connections
- Set up teams with appropriate access controls
- Configure team tokens for workspace automation

## Module Usage

Customer projects are created using the `customer_project` module:

```hcl
module "aws_team_project_1" {
  source = "./modules/customer_project"

  terraform_organization     = var.terraform_organization
  project_name               = "AWS Team Project 1"
  repository_identifier      = "owner/aws-team-project-1"
  oauth_token_id = var.oauth_token_id
}
```

## Adding a New Customer Project

1. Add a new module block to `customer_project.tf`:
   ```hcl
   module "new_project" {
     source = "./modules/customer_project"

     terraform_organization     = var.terraform_organization
     project_name               = "New Project Name"
     repository_identifier      = "owner/new-project-repo"
     oauth_token_id = var.oauth_token_id
   }
   ```

2. Commit and push - the workspace will automatically apply the changes.

## What the Module Creates

For each customer project, the module provisions:

| Resource | Naming Convention |
|----------|-------------------|
| Project | `{project_name}` |
| Workspace | `{project_name} Manager` |
| Team | `{project_name} Workspace Manager` |
| Team Access | Maintain access on project |
| Team Token | Ephemeral, stored as `TFE_TOKEN` in workspace |

## Trigger Configuration

This workspace is configured with:
- **Working Directory:** `2_customer_projects`
- **Trigger Patterns:** `2_customer_projects/**/*`

## Variables

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `terraform_organization` | string | yes | HCP Terraform organization name |
| `oauth_token_id` | string | yes | OAuth Token ID for VCS integration |
| `management_repo_identifier` | string | yes | Repository identifier |

## Outputs

Module outputs are available as:
- `module.<name>.project_id`
- `module.<name>.workspace_id`
- `module.<name>.team_id`
