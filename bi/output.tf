output "bi-resource_group_name" {
  value = azurerm_resource_group.azure-rg.name
}

output "bi-resource_group_location" {
  value = azurerm_resource_group.azure-rg.location
}

output "bi-virtual_network_name" {
  value = azurerm_virtual_network.azure-vnet.name
}

output "bi-subnet_ids" {
    value = {
        for id in keys(var.bi-subnets) : id => azurerm_subnet.azure-subnets[id].id
    }
    description = "Lists of the subnet ID's."
}


output "bi-subnet_names" {
    value = {
        for n in keys(var.bi-subnets) : n => azurerm_subnet.azure-subnets[n].name
    }
    description = "Lists of the subnet ID's."
}

/*
# To generate only a list of the subnet names
output "bi-subnet_names2" {
    value = values(azurerm_subnet.azure-subnets)[*].name
    description = "Lists of the subnet ID's."
}
*/

output "bi-storage_account_names" {
    value = {
        for n in keys(var.bi-storage_accounts) : n => azurerm_storage_account.storage_accounts[n].name
    }
    description = "List of the storage account names."
}

output "bi-storage_account_boot_diagnostic_uris" {
    value = {
        for b in keys (var.bi-storage_accounts) : b => azurerm_storage_account.storage_accounts[b].primary_blob_endpoint
  }
    description = "List of the storage account boot diagnostic URIs."
}

output "bi-storage_container_names" {
    value = {
        for n in keys(var.bi-storage_containers) : n => azurerm_storage_container.azure-storage_conainers[n].name
    }
    description = "List of the storage container names."
}

/* ---
output "bi-bastion_public_ip" {
  value = azurerm_public_ip.bastion_pubip.ip_address
  description = "Public IP of the bastion host"
}
*/ # ---

