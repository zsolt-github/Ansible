data "azurerm_client_config" "current" {
}

resource "random_id" "storage_account" {
  byte_length = 4
}

resource "azurerm_resource_group" "azure-rg" {
  location = var.bi-location
  name     = var.bi-resource_group_name
  
  tags = {
    "ResourceType" = "Resrouce Group"
    "Evironment"   = var.bi-tag_environment
    "Project"      = var.bi-tag_project
  }
}


resource "azurerm_virtual_network" "azure-vnet" {
  name                = var.bi-virtual_network_name
  resource_group_name = azurerm_resource_group.azure-rg.name
  location            = var.bi-location
  address_space       = [var.bi-virtual_network_address_space]
  depends_on          = [azurerm_resource_group.azure-rg]

  tags = {
    "ResourceType" = "Virtual Network"
    "Environment"  = var.bi-tag_environment
  }
}


resource "azurerm_subnet" "azure-subnets" {
  for_each = var.bi-subnets
  resource_group_name  = azurerm_resource_group.azure-rg.name
  virtual_network_name = azurerm_virtual_network.azure-vnet.name
  name                 = each.value["name"]
  address_prefixes     = each.value["address_prefix"]
}

/* ---
resource "azurerm_public_ip" "azure-bastion_pub_ip" {
  name                = var.bi-bastion_public_ip_name
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name
  allocation_method   = var.bi-bastion_public_ip_type
  sku                 = var.bi-bastion_public_ip_sku
  
  tags = {
    "ResourceType" = "Public IP"
    "Environment"  = var.bi-tag_environment
  }
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bi-bastion_host_name
  location            = azurerm_resource_group.azure-rg.location
  resource_group_name = azurerm_resource_group.azure-rg.name
  
  ip_configuration {
    name                 = "bastion_config"
    subnet_id            = azurerm_subnet.azure-subnets["bastion_subnet"].id
    public_ip_address_id = azurerm_public_ip.azure-bastion_pub_ip.id
  }

  tags = {
    "ResourceType" = "Bastion Host"
    "Environment"  = var.bi-tag_environment
  }
}
*/ #---

resource "azurerm_storage_account" "storage_accounts" {
  for_each                        = var.bi-storage_accounts
  resource_group_name             = azurerm_resource_group.azure-rg.name
  location                        = azurerm_resource_group.azure-rg.location

  name                            = "${each.value["name"]}${lower(random_id.storage_account.hex)}"
  account_tier                    = each.value["tier"]
  account_kind                    = each.value["kind"]
  account_replication_type        = each.value["rep_type"]
  enable_https_traffic_only       = each.value["https"]
  access_tier                     = each.value["access_tier"]
  min_tls_version                 = each.value["tls"]
  allow_nested_items_to_be_public = each.value["nested_pub"]

  tags = {
    "ResourceType" = "Storage Account"
    "Evironment"   = var.bi-tag_environment
  }
}

resource "azurerm_storage_container" "azure-storage_conainers" {
  for_each              = var.bi-storage_containers
  name                  = each.value["name"]
  container_access_type = each.value["access_type"]
  #storage_account_name  = azurerm_storage_account.storage_accounts["sa_1"].name
  storage_account_name  = azurerm_storage_account.storage_accounts[each.value["storage_account"]].name
}


/* ---
resource "azurerm_key_vault" "azure-key_vault" {
  name                        = var.bi-key_vault_name
  location                    = var.bi-location
  resource_group_name         = azurerm_resource_group.azure-rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.bi-key_vault_sku
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  #depends_on                  = [azurerm_resource_group.azure-rg]
}


resource "azurerm_key_vault_access_policy" "azure-key_vault_access_poicy-1" {
  key_vault_id = azurerm_key_vault.azure-key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
  depends_on   = [azurerm_key_vault.azure-key_vault]

  key_permissions = [
    "List",
    "Get",
    "Create",
    "Update",
    "Delete",
  ]

  secret_permissions = [
    "List",
    "Set",    
    "Get",
    "Delete",
  ]
}
*/ # ---


