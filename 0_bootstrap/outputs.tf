output "project_id" {
  description = "ID of the Org Management Project"
  value       = tfe_project.org_management.id
}

output "workspace_id" {
  description = "ID of the Organization Administration workspace"
  value       = tfe_workspace.org_administration.id
}
