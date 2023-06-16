/*
variable "bi-tags" {
  type        = map(string)
  description = "Tags used for the deployment"
}
*/

variable "bi-tag_environment" {
    type        = string
    description = "The environment tag."
}

variable "bi-tag_project" {
    #type        = string
    description = "The project tag."
    default     = "Storage"
}


# --- Variables for the Azure Resource Group -------------------------

variable "bi-location" {
    type        = string
    description = "Location of the resources in Azure."
    default     = "UKSouth"
}

variable "bi-resource_group_name" {
    type        = string
    description = "Resource Group name in Azure."
}


# --- Variables for the Azure Virtual Network -------------------------

variable "bi-virtual_network_name" {
    type        = string
    description = "Name of the VLAN in Azure."
}

variable "bi-virtual_network_address_space" {
    type        = string
    description = "The address space of the VLAN in Azure."
}


# --- Variables for Azure the Subnet -------------------------

variable "bi-subnets" {
  type = map(any)
}



# Variables for the Azure Storage Account(s) -------------------------

variable "bi-storage_accounts" {
  type = map(any)
}



# Variables for the Azure Storage Container(s) -------------------------

variable "bi-storage_containers" {
    type        = map(any)
}


/* ---
# Variables for the Azure Key Vault -------------------------

variable "bi-key_vault_name" {
    type        = string
    description = "Name of the Azure Key Vault."
}

variable "bi-key_vault_sku" {
    type        = string
    description = "SKU of the Azure Key Vault. (strandard or premium)"
    default     = "strandard"
}
*/ # ---


/* ---
# Variables for the Bastion host public IP -------------------------

variable "bi-bastion_public_ip_name" {
    type        = string
    description = "Name of the Bastion public IP."
}

variable "bi-bastion_public_ip_type" {
    type        = string
    description = "Type of the Bastion public IP."
}

variable "bi-bastion_public_ip_sku" {
    type        = string
    description = "SKU of Bastion public IP."
}



# Variables for the Azure Bastion Host -------------------------

variable "bi-bastion_host_name" {
  type        = string
  description = "The name of the basion host"
  #default     = "az-bastionhost"
}
*/ # ---
