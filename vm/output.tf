output "vm-nsg_name" {
  value = azurerm_network_security_group.nsg.name
}

output "vm-public_ip" {
  value = data.azurerm_public_ip.public_ip-1.ip_address
}

output "vm-vm_name" {
    value = {
        for n in keys(var.vm-webserver) : n => azurerm_linux_virtual_machine.webserver[n].name
    }
    description = "Lists of VM names."
}

output "vm-vm_public_ip" {
    value = {
        for i in keys(var.vm-webserver) : i => azurerm_linux_virtual_machine.webserver[i].public_ip_address
    }
    description = "Lists of VM public IP addresses."
}

