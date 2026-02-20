# Infrastructure

This folder contains the actual infrastructure code managed by the `aws-s3-bucket-management` workspace.

## Purpose

- Deploy AWS infrastructure resources
- Demonstrate AWS OIDC authentication with HCP Terraform
- Provide an example implementation for customer projects

## Resources Created

### S3 Bucket (`main.tf`)
| Resource | Description |
|----------|-------------|
| `aws_s3_bucket.example` | S3 bucket with generated name |
| `random_string.s3_bucket_suffix` | Random suffix for bucket name uniqueness |

## Authentication

This workspace uses AWS OIDC authentication via HCP Terraform's dynamic credentials feature. The workspace is configured with:

- `TFC_AWS_PROVIDER_AUTH=true` - Enables OIDC authentication
- `TFC_AWS_RUN_ROLE_ARN` - IAM role ARN to assume during runs

No static AWS credentials are stored in the workspace.

## AWS Provider Configuration

The provider is configured to use OIDC authentication automatically when `TFC_AWS_PROVIDER_AUTH` is set:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

## Locals

The `locals.tf` file contains:
- Bucket naming convention
- Tags configuration
- Any computed values

## Variables

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `hashitalks_tag` | string | no | Custom tag value for resources |

## Trigger Configuration

This folder is triggered by changes matching:
- `3_customer_project_code/terraform/infrastructure/**/*`

## Extending

To add more infrastructure resources:

1. Add `.tf` files to this directory
2. Reference any new variables in `variables.tf`
3. Commit and push - the workspace will automatically run
