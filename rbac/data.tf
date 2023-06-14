# Terraform management group
data "azurerm_management_group" "mgt-terraform" {
  name = "Terraform"
}

/*
# The current subscription which is Terraform can be defined like this as well
data "azurerm_subscription" "current" {
}
*/

# Terraform subscription
data "azurerm_subscription" "sub-terraform" {
    subscription_id = "5d0102be-6046-4e6b-97c9-92838eb3ca1b"
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

# Terraform Azure AD user
data "azuread_user" "ad_user-terraform" {
  user_principal_name = "ZF.Terraform@zfcloudoutlook.onmicrosoft.com"
}

# Service principal for Terraform
data "azuread_service_principal" "sp-terraform" {
  display_name = "Terraform-API-Access"
}

# Security group sg-storage-modify
data "azuread_group" "sg-storage-modify" {
  display_name = "sg-storage-modify"
  security_enabled = true
}

