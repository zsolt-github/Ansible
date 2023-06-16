# --- Variable for the environment -------------------------

variable "az_name" {
    type        = string
    description = "Location of the resources in Azure."
}



/*
variable "az_tags" {
  type        = map(string)
  description = "Tags used for the deployment"
  #default = {
  #  "Environment" = "value"
  #  "Project"     = "value"
  }
}
*/

#variable "az_env_postfix" {
#    type        = string
#    description = "The postfix which should be used for all resources in this environment."
#}

variable "tag_environment" {
    type        = string
    description = "The environment tag."
}

variable "tag_project" {
    #type        = string
    description = "The project tag."
    default     = "Storage"
}


# ===========================================================
# ==========      VARIABLES for the BI MODULE      ==========
# ===========================================================

# --- Variables for the Azure Resource Group -------------------------

variable "location" {
    type        = string
    description = "Location of the resources in Azure."
    default     = "UKSouth"
}



# --- Variables for the Azure Virtual Network -------------------------

variable "vnet_address_space" {
    type        = string
    description = "The address space of the VLAN in Azure."
}



# --- Variables for Azure the Subnet -------------------------

variable "subnets" {
    type = map(any)
    #default = {
    #  subnet_1 = {
    #    name             = "subnet_1"
    #    address_prefixes = ["10.13.1.0/24"]
    #  }
    #  subnet_2 = {
    #    name             = "subnet_2"
    #    address_prefixes = ["10.13.2.0/24"]
    #  }
    #}
}


# Variables for the Azure Storage Account(s) -------------------------

variable "storage_accounts" {
    type = map(any)
}


# Variables for the Azure Storage Container(s) -------------------------

variable "storage_containers" {
    type = map(any)
}


/* ---
# Variables for the Azure Key Vault -------------------------

variable "key_vault_sku" {
    type        = string
    description = "SKU of the Azure Key Vault. (strandard or premium)"
    default     = "strandard"
}
*/ # ---

/* ---
# Variables for the Bastion host public IP -------------------------

variable "bastion_public_ip_type" {
    type        = string
    description = "Type of Public IP 1."
}

variable "bastion_public_ip_sku" {
    type        = string
    description = "SKU of Public IP 1."
}


# Variables for the Azure Bastion Host -------------------------

variable "bastion_host_name" {
  type        = string
  description = "The name of the basion host"
  #default     = "az-bastionhost"
}
*/ # ---




# ===========================================================
# =========      VARIABLES for the RBAC MODULE      =========
# ===========================================================

variable "aad_terraform_mgt_group_name" {
  type = string
}

variable "aad_terraform_sub_id" {
  type = string
}

variable "aad_users" {
  type = list
}

variable "aad_sps" {
  type = list
}

variable "aad_groups" {
  type = list
}

# ===========================================================
# ==========      VARIABLES for the VM MODULE      ==========
# ===========================================================

# Variables for Azure Network Security Groups -------------------------



# Variables for the Azure Public IP(s) -------------------------

variable "public_ip_1_type" {
    type        = string
    description = "Type of Public IP 1."
}

variable "public_ip_1_sku" {
    type        = string
    description = "SKU of Public IP 1."
}



# Variables for Azure Network Interface(s) -------------------------



# Variables for Azure Virtual Machine(s) -------------------------

variable "webserver" {
    type        = map(any)
    description = "Webserver Linux VM."
}

/*
variable "virtual_machine_1_size" {
    type        = string
    description = "Name of Virtual Machine 1."
}

variable "virtual_machine_1_computer_name" {
    type        = string
    description = "Computer Name of Virtual Machine 1."
}

variable "virtual_machine_1_admin_user_name" {
    type        = string
    description = "Name of the admin user for Virtual Machine 1."
}

variable "virtual_machine_1_admin_user_password" {
    type        = string
    description = "Password of the admin user for Virtual Machine 1."
    sensitive   = true
}

variable "virtual_machine_1_storage_account_type" {
    type        = string
    description = "Storage account type for Virtual Machine 1. (Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS)"
}

variable "virtual_machine_1_source_image_publisher" {
    type        = string
    description = "Azure Marketplace VM Publisher"
}

variable "virtual_machine_1_source_image_offer" {
    type        = string
    description = "Azure Marketplace VM Offer"
}

variable "virtual_machine_1_source_image_sku" {
    type        = string
    description = "Azure Marketplace VM SKU"
}

variable "virtual_machine_1_source_image_version" {
    type        = string
    description = "Azure Marketplace VM version"
}
/*
variable "virtual_machine_1_plan_name" {
    type        = string
    description = "Azure Marketplace VM Plan Name"
}

variable "virtual_machine_1_plan_product" {
    type        = string
    description = "Azure Marketplace VM Plan Product"
}

variable "virtual_machine_1_plan_publisher" {
    type        = string
    description = "Azure Marketplace VM Plan Publisher"
}




variable "virtual_machine_1_public_key" {
    type        = string
    description = "Location of the Linux VM SSH public key."
}


# ==============================================================================
# ==========      VARIABLES (D)NS, (S)SL, (C)ertificates MODULE       ==========
# ==============================================================================

# --- Variables for Cloudflare -------------------------

variable "cf-zone_id" {
    #type        = string
    description = "Cloudflare Zone ID."
}

variable "cf-a_record_name" {
    #type        = string
    description = "Cloudflare A Record name."
}



# --- Variables for Let's Encrypt -------------------------

variable "acme_email_address" {
    description = "Email address for the Let's Encrypt registration."
}

*/