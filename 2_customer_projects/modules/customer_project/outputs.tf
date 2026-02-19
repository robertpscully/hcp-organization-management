output "project_id" {
  description = "The ID of the customer project"
  value       = tfe_project.this.id
}

output "workspace_id" {
  description = "The ID of the manager workspace"
  value       = tfe_workspace.manager.id
}

output "team_id" {
  description = "The ID of the workspace manager team"
  value       = tfe_team.workspace_manager.id
}
