# HCP Organization Management

This repository contains Terraform configurations for managing an HCP Terraform (formerly Terraform Cloud/Enterprise) organization using a GitOps workflow.

## Architecture

The repository is structured as a multi-stage pipeline where each stage manages specific resources:

```
hcp-organization-management/
├── 0_bootstrap/              # Initial setup (run locally with user token)
├── 1_organization_management/ # Core org resources (managed by workspace)
└── 2_customer_projects/      # Customer project provisioning (managed by workspace)
```

## Workflow

### Stage 0: Bootstrap
Run locally using a user token to create the foundational resources:
- Organization token
- Org Management Project
- Administration workspace with VCS connection
- Variable sets for configuration handoff

### Stage 1: Organization Management
Managed automatically by the `{org}-administration` workspace:
- Imports resources created by bootstrap
- Manages organization-level resources
- Provisions the customer projects workspace

### Stage 2: Customer Projects
Managed automatically by the `{org}-customer-projects` workspace:
- Uses reusable modules to provision customer team projects
- Creates projects, workspaces, teams, and access controls

## Prerequisites

- HCP Terraform organization
- VCS OAuth connection configured in HCP Terraform
- Terraform CLI >= 1.7

## Getting Started

1. Configure variables in `0_bootstrap/terraform.tfvars`:
   ```hcl
   terraform_organization     = "your-org-name"
   oauth_token_id             = "ot-xxxxx"
   management_repo_identifier = "owner/hcp-organization-management"
   ```

2. Run the bootstrap:
   ```bash
   cd 0_bootstrap
   terraform init
   terraform apply
   ```

3. Subsequent changes to `1_organization_management/` and `2_customer_projects/` are automatically applied via VCS-triggered runs.

## Variable Sets

| Variable Set | Scope | Purpose |
|-------------|-------|---------|
| Org Management | Project | TFE_TOKEN, repo identifier for org workspaces |
| Global Variables | Global | oauth_token_id, terraform_organization |
| IMPORT ONLY | Project | Temporary IDs for importing bootstrap resources |
