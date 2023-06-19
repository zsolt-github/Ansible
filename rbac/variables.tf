variable "rbac_terraform_mgt_group_name" {
  type = string
}

variable "rbac_terraform_sub_id" {
  type = string
}

variable "rbac_users" {
  type = list
}

variable "rbac_sps" {
  type = list
}

variable "rbac_groups" {
  type = list
}

variable "rbac_aad_users_to_create" {
  type        = map(any)
  description = "Map of users to create in Azure AD."
}

variable "rbac_aad_groups_to_create" {
  type        = list(string)
  description = "List of groups to create in Azure AD."
}


