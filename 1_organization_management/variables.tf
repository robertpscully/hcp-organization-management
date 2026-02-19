variable "terraform_organization" {
  description = "The name of the Terraform Cloud/Enterprise organization"
  type        = string
}

variable "oauth_token_id" {
  description = "GitHub App Installation ID for VCS integration"
  type        = string
}

variable "management_repo_identifier" {
  description = "Repository identifier for the VCS HCP Organization Management Repo"
  type        = string
}