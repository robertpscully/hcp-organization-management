variable "terraform_organization" {
  description = "The name of the Terraform Cloud/Enterprise organization"
  type        = string
}

variable "project_name" {
  description = "The name of the customer project (used as prefix for workspace and team names)"
  type        = string
}

variable "repo_identifier" {
  description = "The repository identifier for the VCS connection (e.g., owner/repo)"
  type        = string
}

variable "oauth_token_id" {
  description = "GitHub App Installation ID for VCS integration (provided by the organization)"
  type        = string
  default     = null
}
