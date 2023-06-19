data "azurerm_public_ip" "public_ip-1" {
  name = azurerm_public_ip.public_ip-1.name
  resource_group_name = var.vm-resource_group_name
  depends_on = [azurerm_public_ip.public_ip-1, azurerm_linux_virtual_machine.webserver]
}