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

variable "vm-webserver-boot_diag_uri" {
    type        = string
    description = "Name of the webserver."
}

