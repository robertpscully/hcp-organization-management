resource "tfe_workspace" "infrastructure" {
  organization      = var.terraform_organization
  name              = "aws-s3-bucket-management"
  project_id        = var.project_id
  working_directory = "3_customer_project_code/terraform/infrastructure"
  trigger_patterns  = ["3_customer_project_code/terraform/infrastructure/**/*"]

  dynamic "vcs_repo" {
    for_each = var.oauth_token_id != null ? [1] : []
    content {
      branch         = "main"
      oauth_token_id = var.oauth_token_id
      identifier     = var.repo_identifier
    }
  }
}

resource "tfe_variable" "aws_run_role_arn" {
  workspace_id = tfe_workspace.infrastructure.id
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = "arn:aws:iam::613208686742:role/HCPT_demo_create_bucket"
  category     = "env"
  description  = "ARN of the AWS IAM Role to assume for running Terraform in this workspace"
}

resource "tfe_variable" "enable_aws_run_role_arn" {
  workspace_id = tfe_workspace.infrastructure.id
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  description  = "Whether to enable the AWS IAM Role for running Terraform in this workspace"
}

resource "tfe_variable" "hashitalks_tag" {
  workspace_id = tfe_workspace.infrastructure.id
  key          = "hashitalks_tag"
  value        = "let-it-please-the-demo-gods"
  category     = "terraform"
  description  = "The hashitalks tag to use for this workspace"

}
