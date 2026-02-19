module "aws_team_project_1" {
  source = "./modules/customer_project"

  terraform_organization = var.terraform_organization
  project_name           = "AWS Team Project 1"
  repo_identifier        = "robertpscully/hcp-organization-management"
  oauth_token_id         = var.oauth_token_id
}
