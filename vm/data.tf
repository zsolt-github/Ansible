data "azurerm_public_ip" "azure-public_ip-1" {
  name = azurerm_public_ip.azure-public_ip-1.name
  resource_group_name = var.azure-vm_resource_group_name
  depends_on = [ azurerm_public_ip.azure-public_ip-1, azurerm_linux_virtual_machine.azure-linux_virtual_machine-1 ]
}