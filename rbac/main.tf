resource "azurerm_role_assignment" "ra-rbac" {
  for_each             = data.azuread_user.rbac-users
  scope                = data.azurerm_subscription.sub-terraform.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_user.rbac-users[each.key].object_id
}

