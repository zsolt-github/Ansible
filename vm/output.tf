output "vm-nsg_name" {
  value = azurerm_network_security_group.azure-nsg.name
}

output "vm-public_ip" {
  value = data.azurerm_public_ip.azure-public_ip-1.ip_address
}

output "vm-vm_name" {
  value = azurerm_linux_virtual_machine.azure-linux_virtual_machine-1.name
}

output "vm-vm_public_ip" {
  value = azurerm_linux_virtual_machine.azure-linux_virtual_machine-1.public_ip_address
}