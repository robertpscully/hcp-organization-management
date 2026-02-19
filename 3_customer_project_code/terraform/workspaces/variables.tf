variable "terraform_organization" {
  description = "The name of the Terraform Cloud/Enterprise organization"
  type        = string
}

variable "oauth_token_id" {
  description = "OAuth Token ID for VCS integration"
  type        = string

  validation {
    condition     = var.oauth_token_id != null && var.oauth_token_id != ""
    error_message = "oauth_token_id is required and cannot be empty."
  }
}

variable "project_id" {
  description = "The ID of the project to create workspaces in"
  type        = string
}

variable "repo_identifier" {
  description = "The repository identifier for the VCS connection (e.g., owner/repo)"
  type        = string
}
