resource "azurerm_role_assignment" "ra-rbac" {
  for_each             = data.azuread_user.rbac-users
  scope                = data.azurerm_subscription.sub-terraform.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_user.rbac-users[each.key].object_id
}



/*
# Assign the 'Storage Blob Data Contributor' role for the 'sg-storage-modify' group on the Terraform subsription
resource "azurerm_role_assignment" "sg-storage-modify-storage" {
  scope                = data.azurerm_subscription.sub-terraform.id
  role_definition_name = "Storage Blob Data Contributor"
  #role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.sg-storage-modify.id
}

*/




/*

 Error: Management Group "Terraform" was not found
│
│   with module.rbac.data.azurerm_management_group.mgt-terraform,
│   on rbac\data.tf line 2, in data "azurerm_management_group" "mgt-terraform":
│    2: data "azurerm_management_group" "mgt-terraform" {
│
╵
╷
│ Error: Finding user with UPN: "Test1@zfcloudoutlook.onmicrosoft.com"
│
│   with module.rbac.data.azuread_user.rbac-users["Test1@zfcloudoutlook.onmicrosoft.com"],
│   on rbac\data.tf line 26, in data "azuread_user" "rbac-users":
│   26: data "azuread_user" "rbac-users" {
│
│ UsersClient.BaseClient.Get(): unexpected status 403 with OData error: Authorization_RequestDenied: Insufficient privileges to complete the operation.
╵
╷
│ Error: Finding user with UPN: "ZF.Terraform@zfcloudoutlook.onmicrosoft.com"
│
│   with module.rbac.data.azuread_user.rbac-users["ZF.Terraform@zfcloudoutlook.onmicrosoft.com"],
│   on rbac\data.tf line 26, in data "azuread_user" "rbac-users":
│   26: data "azuread_user" "rbac-users" {
│
│ UsersClient.BaseClient.Get(): unexpected status 403 with OData error: Authorization_RequestDenied: Insufficient privileges to complete the operation.
╵
╷
│ Error: Finding user with UPN: "ZF.Terraform@zfcloudoutlook.onmicrosoft.com"
│
│   with module.rbac.data.azuread_user.ad_user-terraform,
│   on rbac\data.tf line 32, in data "azuread_user" "ad_user-terraform":
│   32: data "azuread_user" "ad_user-terraform" {
│
│ UsersClient.BaseClient.Get(): unexpected status 403 with OData error: Authorization_RequestDenied: Insufficient privileges to complete the operation.
╵
╷
│ Error: No group found matching specified filter (displayName eq 'sg-storage-modify' and securityEnabled eq true)
│
│   with module.rbac.data.azuread_group.sg-storage-modify,
│   on rbac\data.tf line 43, in data "azuread_group" "sg-storage-modify":
│   43:   display_name = "sg-storage-modify"
│
│ GroupsClient.BaseClient.Get(): unexpected status 403 with OData error: Authorization_RequestDenied: Insufficient privileges to complete the operation.
╵


*/