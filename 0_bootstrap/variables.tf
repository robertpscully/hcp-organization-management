variable "terraform_organization" {
  description = "The name of the Terraform Cloud/Enterprise organization"
  type        = string
}

variable "token_expiry_days" {
  description = "Number of days until the organization token expires"
  type        = number
  default     = 7
}


variable "oauth_token_id" {
  description = "OAuth Token ID for VCS integration (https://app.terraform.io/app/settings/tokens)"
  type        = string
}

variable "management_repo_identifier" {
  description = "Repository identifier for the VCS HCP Organization Management Repo"
  type        = string
}