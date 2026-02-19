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
  vcs_repo {
    branch             = "main"
    oauth_token_id     = var.oauth_token_id
    identifier         = var.management_repo_identifier
    ingress_submodules = false
  }
}

resource "tfe_workspace" "customer_projects" {
  organization = var.terraform_organization
  name         = "${var.terraform_organization}-customer-projects"
  project_id   = tfe_project.org_management.id
  trigger_patterns = [
    "2_customer_projects/**/*",
  ]
  working_directory = "2_customer_projects"
  vcs_repo {
    branch             = "main"
    oauth_token_id     = var.oauth_token_id
    identifier         = var.management_repo_identifier
    ingress_submodules = false
  }
}

