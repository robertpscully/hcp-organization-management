resource "tfe_variable_set" "importonly_variables" {
  organization = var.terraform_organization
  name         = "IMPORT ONLY for Bootstrap"
  description  = "Temporary variable set used to import existing resources to the stable pipeline"
}

resource "tfe_project_variable_set" "importonly_variable_set" {
  project_id      = tfe_project.org_management.id
  variable_set_id = tfe_variable_set.importonly_variables.id
}

resource "tfe_variable" "importonly_project_id" {
  variable_set_id = tfe_variable_set.importonly_variables.id
  key             = "importonly_project_id"
  value           = tfe_project.org_management.id
  category        = "terraform"
  description     = "(IMPORT ONLY) Project ID for the Org Management Project"
}

resource "tfe_variable" "importonly_global_variable_varset" {
  variable_set_id = tfe_variable_set.importonly_variables.id
  key             = "importonly_global_variable_varset_id"
  value           = tfe_variable_set.global_variables.id
  category        = "terraform"
  description     = "(IMPORT ONLY) ID for global variable set"
}

resource "tfe_variable" "importonly_org_management_varset" {
  variable_set_id = tfe_variable_set.importonly_variables.id
  key             = "importonly_org_management_varset_id"
  value           = tfe_variable_set.org_management.id
  category        = "terraform"
  description     = "(IMPORT ONLY) ID for org management variable set"
}

resource "tfe_variable" "importonly_global_variable_var_oauth_token_id" {
  variable_set_id = tfe_variable_set.importonly_variables.id
  key             = "importonly_global_variable_var_oauth_token_id"
  value           = tfe_variable.oauth_token_id.id
  category        = "terraform"
  description     = "(IMPORT ONLY) ID for the oauth_token_id variable in the Global Variables Variable Set"
}

resource "tfe_variable" "importonly_global_variable_var_terraform_organization_id" {
  variable_set_id = tfe_variable_set.importonly_variables.id
  key             = "importonly_global_variable_var_terraform_organization_id"
  value           = tfe_variable.terraform_organization.id
  category        = "terraform"
  description     = "(IMPORT ONLY) ID for the terraform_organization variable in the Global Variables Variable Set"
}

resource "tfe_variable" "importonly_management_repo_identifier" {
  variable_set_id = tfe_variable_set.importonly_variables.id
  key             = "importonly_org_management_var_management_repo_identifier_id"
  value           = tfe_variable.management_repo_identifier.id
  category        = "terraform"
  description     = "(IMPORT ONLY) Management repo identifier"
}
