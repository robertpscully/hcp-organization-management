resource "tfe_project" "this" {
  organization = var.terraform_organization
  name         = var.project_name
}

resource "tfe_workspace" "manager" {
  organization      = var.terraform_organization
  name              = lower(replace("${var.project_name}-manager", " ", "-"))
  project_id        = tfe_project.this.id
  working_directory = "3_customer_project_code/terraform/workspaces"
  trigger_patterns  = ["3_customer_project_code/terraform/workspaces/**/*"]

  dynamic "vcs_repo" {
    for_each = var.oauth_token_id != null ? [1] : []
    content {
      branch             = "main"
      oauth_token_id     = var.oauth_token_id
      identifier         = var.repo_identifier
      ingress_submodules = false
    }
  }
}

resource "tfe_team" "workspace_manager" {
  organization = var.terraform_organization
  name         = "${var.project_name} Workspace Manager"
}

resource "tfe_team_project_access" "workspace_manager" {
  team_id    = tfe_team.workspace_manager.id
  project_id = tfe_project.this.id
  access     = "maintain"


}

ephemeral "tfe_team_token" "workspace_manager" {
  team_id = tfe_team.workspace_manager.id
}

resource "tfe_variable" "tfe_token" {
  workspace_id = tfe_workspace.manager.id
  key          = "TFE_TOKEN"
  value_wo     = ephemeral.tfe_team_token.workspace_manager.token
  category     = "env"
  sensitive    = true
  description  = "Team token for ${var.project_name} Workspace Manager"
}

resource "tfe_variable" "project_id" {
  workspace_id = tfe_workspace.manager.id
  key          = "project_id"
  value        = tfe_project.this.id
  category     = "terraform"
  description  = "ID of the Terraform Cloud project this workspace can deploy to"
}

resource "tfe_variable" "repo_identifier" {
  workspace_id = tfe_workspace.manager.id
  key          = "repo_identifier"
  value        = var.repo_identifier
  category     = "terraform"
  description  = "Repository identifier for the VCS connection"
}
