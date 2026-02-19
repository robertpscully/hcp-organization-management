variable "importonly_project_id" {
  description = "(IMPORT ONLY) The ID of the Org Management Project"
}

variable "importonly_global_variable_varset_id" {
  description = "(IMPORT ONLY) The ID of the Global Variables Variable Set"
}

variable "importonly_global_variable_var_oauth_token_id" {
  description = "(IMPORT ONLY) The ID of the Variable for the GitHub App Installation ID in the Global Variables Variable Set"
}

variable "importonly_global_variable_var_terraform_organization_id" {
  description = "(IMPORT ONLY) The name of the Variable for the Terraform Organization in the Global Variables Variable Set"
}

variable "importonly_org_management_varset_id" {
  description = "(IMPORT ONLY) The ID of the Org Management Variable Set"
}

variable "importonly_org_management_var_management_repo_identifier_id" {
  description = "(IMPORT ONLY) The name of the Variable for the Management Repo Identifier in the Org Management Variable Set"
}

import {
  to = tfe_project.org_management
  id = var.importonly_project_id
}

import {
  to = tfe_workspace.org_administration
  id = "${var.terraform_organization}/${var.terraform_organization}-administration"
}

import {
  to = tfe_variable_set.org_management
  id = var.importonly_org_management_varset_id
}

import {
  to = tfe_project_variable_set.org_management
  id = "${var.terraform_organization}/${tfe_project.org_management.id}/Org Management"
}


import {
  to = tfe_variable.management_repo_identifier
  id = "${var.terraform_organization}/${tfe_variable_set.org_management.id}/${var.importonly_org_management_var_management_repo_identifier_id}"
}

import {
  to = tfe_variable_set.global_variables
  id = var.importonly_global_variable_varset_id
}

import {
  to = tfe_variable.oauth_token_id
  id = "${var.terraform_organization}/${tfe_variable_set.global_variables.id}/${var.importonly_global_variable_var_oauth_token_id}"
}

import {
  to = tfe_variable.terraform_organization
  id = "${var.terraform_organization}/${tfe_variable_set.global_variables.id}/${var.importonly_global_variable_var_terraform_organization_id}"
}
