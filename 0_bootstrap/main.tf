resource "tfe_organization_token" "main" {
  organization = var.terraform_organization

  expired_at       = timeadd(timestamp(), "${var.token_expiry_days * 24}h")
  force_regenerate = false

  lifecycle {
    ignore_changes = [expired_at]
  }
}

resource "tfe_project" "org_management" {
  organization = var.terraform_organization
  name         = "Org Management Project"
}

resource "tfe_workspace" "org_administration" {
  organization = var.terraform_organization
  name         = "${var.terraform_organization}-administration"
  project_id   = tfe_project.org_management.id
  trigger_patterns = [
    "1_organization_management/**/*",
  ]
  working_directory = "1_organization_management"
  dynamic "vcs_repo" {
    for_each = var.oauth_token_id != "" ? [1] : []
    content {
      branch             = "main"
      oauth_token_id     = var.oauth_token_id
      identifier         = var.management_repo_identifier
      ingress_submodules = false
    }
  }
}
