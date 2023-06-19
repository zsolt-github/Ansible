resource "azuread_user" "aad_users_to_create" {
  for_each = var.rbac_aad_users_to_create

  user_principal_name         = each.value.user_principal_name
  display_name                = each.value.display_name
  password                    = each.value.password
  account_enabled             = each.value.account_enabled
  force_password_change       = each.value.force_password_change
  disable_password_expiration = each.value.disable_password_expiration
  country                     = each.value.country
  department                  = each.value.department
  job_title                   = each.value.job_title
}


resource "azuread_group" "aad_groups_to_create" {
  for_each = toset(var.rbac_aad_groups_to_create)

  display_name     = each.key
  security_enabled = true
}


resource "azuread_group_member" "aad_add_existing_users_to_group" {
  for_each = data.azuread_user.rbac-users

  group_object_id  = data.azuread_group.rbac-existing-groups["sg-storage-rw"].object_id
  member_object_id = each.value.object_id
}


resource "azuread_group_member" "aad_add_new_users_to_group" {
  for_each = {
    for user in azuread_user.aad_users_to_create : "${user.user_principal_name}-${azuread_group.aad_groups_to_create["sg-storage-rw-2"].display_name}" => {
      user_id  = user.object_id
      group_id = azuread_group.aad_groups_to_create["sg-storage-rw-2"].object_id
    }
  }

  group_object_id  = each.value.group_id
  member_object_id = each.value.user_id
}


resource "azurerm_role_assignment" "ra-users" {
  for_each             = data.azuread_user.rbac-users
  scope                = data.azurerm_subscription.sub-terraform.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_user.rbac-users[each.key].object_id
}

resource "azurerm_role_assignment" "ra-groups" {
  for_each             = data.azuread_group.rbac-existing-groups
  scope                = data.azurerm_subscription.sub-terraform.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_group.rbac-existing-groups["sg-storage-rw"].object_id
}

resource "azurerm_role_assignment" "ra-new-groups" {
  for_each = toset(["sg-storage-rw-2", "sg-storage-rw-3"])

  scope                = data.azurerm_subscription.sub-terraform.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_group.aad_groups_to_create[each.key].object_id
}



