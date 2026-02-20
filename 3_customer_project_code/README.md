# 3_customer_project_code

This folder contains an example customer project implementation that demonstrates the workspace hierarchy pattern.

## Architecture

```
3_customer_project_code/
└── terraform/
    ├── workspaces/      # Workspace definitions (managed by project manager workspace)
    └── infrastructure/  # Actual infrastructure code (managed by workspaces defined above)
```

## Workflow

1. **Project Creation** (`2_customer_projects/`)
   - Creates a project and manager workspace
   - Manager workspace targets `3_customer_project_code/terraform/workspaces/`

2. **Workspace Definition** (`terraform/workspaces/`)
   - Defines infrastructure workspaces within the project
   - Configures AWS OIDC authentication
   - Sets up workspace variables

3. **Infrastructure Deployment** (`terraform/infrastructure/`)
   - Contains actual infrastructure code (S3 buckets, etc.)
   - Managed by workspaces defined in step 2

## Directory Structure

### `terraform/workspaces/`
Managed by the `{project_name}-manager` workspace. Creates:
- Infrastructure workspaces with VCS connections
- AWS OIDC configuration for dynamic credentials
- Workspace variables for AWS provider authentication

### `terraform/infrastructure/`
Contains the actual infrastructure code deployed by workspaces. Currently includes:
- S3 bucket creation with random suffix
- AWS provider configuration using OIDC

## AWS OIDC Integration

The workspaces are configured with AWS OIDC authentication:
- `TFC_AWS_PROVIDER_AUTH` - Enables AWS provider authentication
- `TFC_AWS_RUN_ROLE_ARN` - IAM role ARN to assume

This allows Terraform runs to authenticate with AWS without static credentials.
