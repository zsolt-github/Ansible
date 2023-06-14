data "azurerm_client_config" "current" {
}

locals {
  name = "${terraform.workspace}-${var.az_name}"
  #tags = merge(var.az_tag_project, {"env" = terraform.workspace, "app" = local.name})
}

resource "random_id" "random_id" {
  byte_length = 2
}


# ---- Base Infrasturcture module ----------------------------
module "bi" {
  source = "./bi"

  bi-tag_environment = var.tag_environment
  bi-tag_project     = var.tag_project

  bi-location            = var.location
  bi-resource_group_name = "${local.name}-RG"

  bi-virtual_network_name          = "${local.name}-VNET"
  bi-virtual_network_address_space = var.vnet_address_space

  bi-subnets = var.subnets

  /* ---
  bi-bastion_public_ip_name = "Bastion-PUB_IP"
  #bi-bastion_public_ip_name = "${var.bastion_host_name}-PUB_IP"
  bi-bastion_public_ip_type = var.bastion_public_ip_type
  bi-bastion_public_ip_sku  = var.bastion_public_ip_sku

  bi-bastion_host_name = var.bastion_host_name
  */ # ---

  
  bi-storage_accounts = var.storage_accounts

  bi-storage_containers = var.storage_containers

  
  /* ---
  bi-key_vault_name = "Test123456-KeyVault"
  # Depending on the lenght of the 'az_name' variable the key vault name can't be generated
  # because it gets too long (longer than the maximum allowed 24 characters)
  #
  #bi-key_vault_name = "${var.az_name}${random_id.random_id.dec}-KeyVault"
  bi-key_vault_sku  = var.key_vault_sku
  */ # ---
}


/*
# ---- Role Based Access Control module ----------------------------
module "rbac" {
  source = "./rbac"

  depends_on  = [module.bi]

  rbac_users  = var.aad_users
  rbac_sps    = var.aad_sps
  rbac_groups = var.aad_groups


}
*/

/*
# ---- Virtual mahcine module ----------------------------
module "vm" {
  source = "./vm"

  depends_on               = [module.rbac]

  vm-tag_environment = var.tag_environment
  vm-tag_project     = var.tag_project

  vm-location            = var.location
  vm-resource_group_name = module.bi.resource_group_name

  vm-nsg_name = "${local.name}-NSG1"

  vm-public_ip_1_name = "${local.name}-PUB_IP1"
  vm-public_ip_1_type = var.public_ip_1_type
  vm-public_ip_1_sku  = var.public_ip_1_sku

  vm-net_int-1 = "${local.name}-NET_INT1"
  vm-subnet_id = module.bi.subnet_1_id

  vm-virtual_machine_1_name           = "${local.name}-VM"
  vm-virtual_machine_1_size                 = var.virtual_machine_1_size
  vm-virtual_machine_1_computer_name  = var.virtual_machine_1_computer_name
  vm-virtual_machine_1_admin_user_name      = var.virtual_machine_1_admin_user_name
  vm-virtual_machine_1_admin_user_password  = var.virtual_machine_1_admin_user_password
  vm-virtual_machine_1_storage_account_type = var.virtual_machine_1_storage_account_type

  vm-virtual_machine_1_source_image_publisher = var.virtual_machine_1_source_image_publisher
  vm-virtual_machine_1_source_image_offer     = var.virtual_machine_1_source_image_offer
  vm-virtual_machine_1_source_image_sku       = var.virtual_machine_1_source_image_sku
  vm-virtual_machine_1_source_image_version   = var.virtual_machine_1_source_image_version

  #vm-virtual_machine_1_plan_name              = var.virtual_machine_1_plan_name
  #vm-virtual_machine_1_plan_product           = var.virtual_machine_1_plan_product
  #vm-virtual_machine_1_plan_publisher         = var.virtual_machine_1_plan_publisher

  vm-virtual_machine_1_public_key               = var.virtual_machine_1_public_key
  vm-virtual_machine_1_boot_diagnostic_uri      = module.bi.storage_account_boot_diagnostic_uri

}


# =======================================================
# ====      (D)NS, (S)SL, (C)ertificates module      ====
# =======================================================

module "dsc" {
  source = "./dsc"

  depends_on                = [module.vm]

  dsc-storage_account_name        = module.bi.az-storage_account_name
  dsc-container_1_name            = module.bi.az-container_1_name

  dsc-cloudflare_zone_id       = var.cf-zone_id
  dsc-cloudflare_a_record_name = var.cf-a_record_name
  dsc-cloudflare_public_ip     = module.vm.public_ip

  dsc-acme_email_address       = var.acme_email_address

}
*/

