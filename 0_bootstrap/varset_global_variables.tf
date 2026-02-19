resource "tfe_variable_set" "global_variables" {
  organization = var.terraform_organization
  name         = "Global Variables"
  description  = "Common Variables for Workspace Vending workspaces"
  global       = true
}

resource "tfe_variable" "oauth_token_id" {
  variable_set_id = tfe_variable_set.global_variables.id
  key             = "oauth_token_id"
  value           = var.oauth_token_id
  category        = "terraform"
  description     = "GitHub App Installation ID for VCS integration"
}

resource "tfe_variable" "terraform_organization" {
  variable_set_id = tfe_variable_set.global_variables.id
  key             = "terraform_organization"
  value           = var.terraform_organization
  category        = "terraform"
  description     = "The name of the HCP Terraform organization"
}
