# Terraform management group
data "azurerm_management_group" "mgt-terraform" {
  name = var.rbac_terraform_mgt_group_name
}

/*
# The current subscription which is Terraform can be defined like this as well
data "azurerm_subscription" "current" {
}
*/

# Terraform subscription
data "azurerm_subscription" "sub-terraform" {
    subscription_id = var.rbac_terraform_sub_id
}

/*
# Production subscription
data "azurerm_subscription" "sub-prod" {
    subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
*/

# Query the Principal ID for each user in support_users
data "azuread_user" "rbac-users" {
  for_each            = toset(var.rbac_users)
  user_principal_name = format("%s", each.key)
}

# Security group sg-storage-modify
data "azuread_group" "sg-storage-rw" {
  for_each         = toset(var.rbac_groups)
  display_name     = format("%s", each.key)
  security_enabled = true
}

