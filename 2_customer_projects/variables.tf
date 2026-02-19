variable "terraform_organization" {
  description = "The name of the Terraform Cloud/Enterprise organization"
  type        = string
}

variable "oauth_token_id" {
  description = "OAuth token ID for connecting Terraform Cloud to a VCS repository"
  type        = string
}
