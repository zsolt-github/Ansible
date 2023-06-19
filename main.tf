data "azurerm_client_config" "current" {
}

locals {
  name = "${terraform.workspace}-${var.az_name}"
  #tags = merge(var.az_tag_project, {"env" = terraform.workspace, "app" = local.name})
}

resource "random_id" "random_id" {
  byte_length = 2
}


# ==================================================
# ====      (B)ase (I)nfrastructure module      ====
# ==================================================

module "bi" {
  source                           = "./bi"

  bi-tag_environment               = var.tag_environment
  bi-tag_project                   = var.tag_project

  bi-location                      = var.location
  bi-resource_group_name           = "${local.name}-RG"

  bi-virtual_network_name          = "${local.name}-VNET"
  bi-virtual_network_address_space = var.vnet_address_space

  bi-subnets                       = var.subnets

  bi-storage_accounts              = var.storage_accounts

  bi-storage_containers            = var.storage_containers

  
  /* ---
  bi-key_vault_name = "Test123456-KeyVault"
  # Depending on the lenght of the 'az_name' variable the key vault name can't be generated
  # because it gets too long (longer than the maximum allowed 24 characters)
  #
  #bi-key_vault_name = "${var.az_name}${random_id.random_id.dec}-KeyVault"
  bi-key_vault_sku  = var.key_vault_sku
  */ # ---

  /* ---
  bi-bastion_public_ip_name = "Bastion-PUB_IP"
  #bi-bastion_public_ip_name = "${var.bastion_host_name}-PUB_IP"
  bi-bastion_public_ip_type = var.bastion_public_ip_type
  bi-bastion_public_ip_sku  = var.bastion_public_ip_sku

  bi-bastion_host_name = var.bastion_host_name
  */ # ---
}



# ============================================================
# ====      (R)ole (B)ased (A)ccess (C)ontrol module      ====
# ============================================================

module "rbac" {
  source                        = "./rbac"

  depends_on                    = [module.bi]

  rbac_terraform_mgt_group_name = var.aad_terraform_mgt_group_name

  rbac_terraform_sub_id         = var.aad_terraform_sub_id

  rbac_users                    = var.aad_users
  rbac_sps                      = var.aad_sps
  rbac_groups                   = var.aad_groups

  rbac_aad_users_to_create      = var.aad_users_to_create
  rbac_aad_groups_to_create     = var.aad_groups_to_create

}



# ==============================================
# ====      (V)irtual (M)achine module      ====
# ==============================================

module "vm" {
  source                     = "./vm"

  depends_on                 = [module.bi]

  vm-tag_environment         = var.tag_environment
  vm-tag_project             = var.tag_project

  vm-location                = var.location
  vm-resource_group_name     = module.bi.bi-resource_group_name

  vm-nsg_name                = "${local.name}-NSG1"

  vm-public_ip_1_name        = "${local.name}-PUB_IP1"
  vm-public_ip_1_type        = var.public_ip_1_type
  vm-public_ip_1_sku         = var.public_ip_1_sku

  vm-net_int-1               = "${local.name}-NET_INT1"
  vm-subnet_id               = module.bi.bi-subnet_ids["subnet_1"]

  vm-webserver_name          = "${local.name}-VM"
  vm-webserver               = var.webserver
  vm-webserver-boot_diag_uri = module.bi.bi-storage_account_boot_diagnostic_uris["sa_1"]
}



# =======================================================
# ====      (D)NS, (S)SL, (C)ertificates module      ====
# =======================================================

module "dsc" {
  source                       = "./dsc"

  depends_on                   = [module.vm]

  dsc-storage_account_name     = module.bi.bi-storage_account_names["sa_2"]
  dsc-container_1_name         = module.bi.bi-storage_container_names["container_1"]
  dsc-container_2_name         = module.bi.bi-storage_container_names["container_2"]

  dsc-cloudflare_zone_id       = var.cf-zone_id
  dsc-cloudflare_a_record_name = var.cf-a_record_name
  dsc-cloudflare_public_ip     = module.vm.vm-public_ip

  dsc-acme_email_address       = var.acme_email_address

}

