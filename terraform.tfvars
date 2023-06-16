# --- Azure Environment postfix variable -------------------------
az_name            = "Ansible-Test"
/*
tags               = {
                        "Environment" = "value"
                        "Project"     = "value"
                     }
*/

tag_environment = "Demo-Ansible-Test"
tag_project     = "Ansible-Test"



# --- Azure main variables -------------------------
location            = "UKSouth"



# =============== VARIABLES for the BI MODULE ===============

# --- Azure Virtual Network variables -------------------------
vnet_address_space = "10.170.0.0/16"



# --- Azure Subnet variables -------------------------
subnets = {
  subnet_1 = {
    name    =   "front_end"
    address_prefix  =   ["10.170.1.0/24"]
  }
  subnet_2 = {
    name    =   "subnet_2"
    address_prefix  =   ["10.170.2.0/24"]
  }
  subnet_3 = {
    name    =   "backend"
    address_prefix  =   ["10.170.3.0/24"]
  }
  # The name must be AzureBastionSubnet
  bastion_subnet = {
    name             = "AzureBastionSubnet"
    address_prefix = ["10.170.250.0/27"]
  }  
}



# --- Azure Storage account variables -------------------------
storage_accounts = {
  sa_1 = {
    name        = "sa1"           # 3-24 characters and lower case letters and numbers
    tier        = "Standard"      # Standard, Premium
    kind        = "StorageV2"
    rep_type    = "LRS"           # LRS, ZRS, GRS, GZRS
    https       = "true"
    access_tier = "Hot"           # Hot, Cool
    tls         = "TLS1_2"        # TLS1_0, TLS1_1, TLS1_2
    nested_pub  = "true"
  }
  sa_2 = {
    name        = "sa2"
    tier        = "Standard"
    kind        = "StorageV2"
    rep_type    = "LRS"
    https       = "true"
    access_tier = "Cool"
    tls         = "TLS1_1"
    nested_pub  = "true"
  }
}


# --- Azure Storage container variables -------------------------
storage_containers = {
  container_1 = {
    name            = "certs"        # 3-63 characters, lower case letters, numbers and dash (-)
    access_type     = "container"    # blob, container, private
    storage_account = "sa_1"
  }
  container_2 = {
    name            = "temp"
    access_type     = "blob"
    storage_account = "sa_1"
  }
  container_3 = {
    name            = "corp-files"
    access_type     = "private"
    storage_account = "sa_2"
  }
}


/* ---
# --- Azure Key Vault variables -------------------------

key_vault_sku = "standard"
*/ # ---


/* ---
# --- Variables for the Bastion host public IP -------------------------

bastion_public_ip_type = "Static"
bastion_public_ip_sku  = "Standard"



# --- Variables for the Azure Bastion Host -------------------------

bastion_host_name = "Bastion_Host"
*/ # ---



# ===========================================================
# =========      VARIABLES for the RBAC MODULE      =========
# ===========================================================

aad_terraform_mgt_group_name = "Terraform"

aad_terraform_sub_id = "5d0102be-6046-4e6b-97c9-92838eb3ca1b"

aad_users = [
  "Test1@zfcloudoutlook.onmicrosoft.com",
  "Test2@zfcloudoutlook.onmicrosoft.com"
]

aad_sps = [
  "Terraform-API-Access",
]

aad_groups = [
  "sg-storage-rw",
]


# ===========================================================
# ==========      VARIABLES for the VM MODULE      ==========
# ===========================================================

# --- Azure Network Security Group variables -------------------------



# --- Azure Public IP variables -------------------------
public_ip_1_type = "Dynamic"
public_ip_1_sku  = "Basic"



# --- Azure Network Interfaces variables -------------------------



# --- Azure Virtual Machines variable -------------------------
vm-webserver = {
  webserver-1 = {
    name                            = "webserver"
    size                            = "Standard_B1s" # Standard_B1s / Standard_B2s
    computer_name                   = "webserver"
    admin_username                  = "adminuser"
    admin_password                  = "AdminPassword-2022"
    disable_password_authentication = "false"

    os_disk_name                    = "OSDisk"
    os_disk_caching                 = "ReadWrite"
    storage_account_type            = "StandardSSD_LRS"

    publisher                       = "canonical" # this is the Plan Publisher as well
    offer                           = "0001-com-ubuntu-server-lunar" # this is the Plan Product as well
    sku                             = "23_04" # this is the Plan Name as well
    version                         = "latest"

    public_key                      = "~/.ssh/az-webserver_ssh_key.pub"
  }
}

/*
virtual_machine_1_computer_name        = "Ansible-TF"
virtual_machine_1_size                 = "Standard_B2s"
virtual_machine_1_admin_user_name      = "adminuser"
virtual_machine_1_admin_user_password  = "AdminPassword-2022"
virtual_machine_1_storage_account_type = "StandardSSD_LRS"


# --- Azure Marketplace Virtual Machines variables -------------------------
virtual_machine_1_source_image_publisher = "canonical"
virtual_machine_1_source_image_offer     = "0001-com-ubuntu-server-lunar"
virtual_machine_1_source_image_sku       = "23_04"
virtual_machine_1_source_image_version   = "latest"

#virtual_machine_1_plan_name              = "23_04"
#virtual_machine_1_plan_product           = "0001-com-ubuntu-server-lunar"
#virtual_machine_1_plan_publisher         = "canonical"

virtual_machine_1_public_key              = "~/.ssh/az-webserver_ssh_key.pub"


# =============================================================================
# ==========      VARIABLES (D)NS, (S)SL, (C)ertificates MODULE       =========
# =============================================================================

# --- Cloudflare variables -------------------------
cf-zone_id = "a2e568d712316a47c0acaecaa9aec69e"
cf-a_record_name = "webserver"



# --- Let's Encrypt variables -------------------------
acme_email_address = "myemail@mailbox.org"
*/

