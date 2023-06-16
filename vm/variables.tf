# --- Variable for the environment -------------------------

variable "vm-tag_environment" {
    type        = string
    description = "The environment tag."
}

variable "vm-tag_project" {
    #type        = string
    description = "The project tag."
    default     = "Storage"
}



# --- Variables for the Azure Resource Group -------------------------

variable "vm-location" {
    type        = string
    description = "Location of the resources in Azure."
}

variable "vm-resource_group_name" {
    type        = string
    description = "Resource group name."
}


# --- Variables for Azure Network Security Groups -------------------------

variable "vm-nsg_name" {
    type        = string
    description = "Network Security Group name."
}

# --- Variables for the Azure Public IP(s) -------------------------

variable "vm-public_ip_1_name" {
    type        = string
    description = "Network Security Group name."
}

variable "vm-public_ip_1_type" {
    type        = string
    description = "Type of Public IP 1."
}

variable "vm-public_ip_1_sku" {
    type        = string
    description = "SKU of Public IP 1."
}


# --- Variables for Azure Network Interface(s) -------------------------

variable "vm-net_int-1" {
    type        = string
    description = "Network Security Group name."
}

variable "vm-subnet_id" {
    #type        = string
    description = "Network Security Group name."
}


# --- Variables for Azure Virtual Machine(s) -------------------------

variable "vm-webserver_name" {
    type        = string
    description = "Name of the webserver."
}

variable "vm-webserver" {
    type        = map(any)
    description = "Webserver Linux VM."
}


/*
variable "vm-virtual_machine_1_name" {
    type        = string
    description = "Name of Virtual Machine 1."
}

variable "vm-virtual_machine_1_size" {
    #type        = string
    description = "Size of Virtual Machine 1."
}

variable "vm-virtual_machine_1_computer_name" {
    type        = string
    description = "Computer Name of Virtual Machine 1."
}

variable "vm-virtual_machine_1_admin_user_name" {
    type        = string
    description = "Name of the admin user for Virtual Machine 1."
}

variable "vm-virtual_machine_1_admin_user_password" {
    #type        = string
    description = "Password of the admin user for Virtual Machine 1."
    sensitive   = true
}

variable "vm-virtual_machine_1_storage_account_type" {
    #type        = string
    description = "Storage account type for Virtual Machine 1. (Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS)"
}

variable "vm-virtual_machine_1_source_image_publisher" {
    #type        = string
    description = "Azure Marketplace VM Publisher"
}

variable "vm-virtual_machine_1_source_image_offer" {
    #type        = string
    description = "Azure Marketplace VM Offer"
}

variable "vm-virtual_machine_1_source_image_sku" {
    #type        = string
    description = "Azure Marketplace VM SKU"
}

variable "vm-virtual_machine_1_source_image_version" {
    #type        = string
    description = "Azure Marketplace VM version"
}
/*
variable "vm-virtual_machine_1_plan_name" {
    type        = string
    description = "Azure Marketplace VM Plan Name"
}

variable "vm-virtual_machine_1_plan_product" {
    type        = string
    description = "Azure Marketplace VM Plan Product"
}

variable "vm-virtual_machine_1_plan_publisher" {
    type        = string
    description = "Azure Marketplace VM Plan Publisher"
}

variable "vm-virtual_machine_1_public_key" {
    #type        = string
    description = "Linux VM public key location."
}

variable "vm-virtual_machine_1_boot_diagnostic_uri" {
    #type        = string
    description = "Azure storage account primary blob endpoint for Linux VM boot diagnostics."
}
*/



