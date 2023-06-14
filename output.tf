# ===========================================================
# ===========      OUTPUT from the BI MODULE      ===========
# ===========================================================

output "resource_group_name" {
  value = module.bi.bi-resource_group_name
}

output "resource_group_location" {
  value = module.bi.bi-resource_group_location
}

output "virtual_network_name" {
  value = module.bi.bi-virtual_network_name
}

output "subnet_ids" {
  value = module.bi.bi-subnet_ids
}

output "subnet_names" {
  value = module.bi.bi-subnet_names
}

output "storage_account_names"{
  value = module.bi.bi-storage_account_names
}

output "storage_account_boot_diagnostic_uris"{
  value = module.bi.bi-storage_account_boot_diagnostic_uris
}

output "storage_container_names"{
  value = module.bi.bi-storage_container_names
}

/* ---
output "bastion_public_ip"{
  value = module.bi.bi-bastion_public_ip
}
*/ # ---




# ===========================================================
# ===========      OUTPUT from the VM MODULE      ===========
# ===========================================================

/*
output "nsg_name" {
  value = module.vm.vm-nsg_name
}

output "public_ip" {
  value = module.vm.vm-public_ip
}

output "virtual_machine_name" {
  value = module.vm.vm-vm_name
}

output "virtual_machine_public_ip" {
  value = module.vm.vm-vm_public_ip
}



# ===========================================================
# ==========      OUTPUT from the DSC MODULE      ===========
# ===========================================================

output "webserver_hostname" {
  value = module.dsc.dsc-webserver_dns_name
}
*/