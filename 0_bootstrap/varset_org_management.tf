resource "tfe_variable_set" "org_management" {
  organization = var.terraform_organization
  name         = "Org Management"
  description  = "Common Variables for Org Management Project"
}

resource "tfe_project_variable_set" "org_management" {
  project_id      = tfe_project.org_management.id
  variable_set_id = tfe_variable_set.org_management.id
}

resource "tfe_variable" "tfe_token" {
  variable_set_id = tfe_variable_set.org_management.id
  key             = "TFE_TOKEN"
  value_wo        = tfe_organization_token.main.token
  category        = "env"
  sensitive       = true
  description     = "TFE organization token for authentication"
}

resource "tfe_variable" "management_repo_identifier" {
  variable_set_id = tfe_variable_set.org_management.id
  key             = "management_repo_identifier"
  value           = var.management_repo_identifier
  category        = "terraform"
  description     = "Repository identifier for the VCS HCP Organization Management Repo"
}