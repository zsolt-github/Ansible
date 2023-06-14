resource "azurerm_network_security_group" "azure-nsg" {
  name                = var.vm-nsg_name
  location            = var.vm-location
  resource_group_name = var.vm-resource_group_name
  
  security_rule {
    name                       = "Inbound-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Inbound-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
   }

  security_rule {
    name                       = "Inbound-HTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
   }

  security_rule {
    name                       = "PING"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
   }

  tags = {
    "ResourceType" = "Network Security Group"
    "Environment"  = var.vm-tag_environment
  }
}


resource "azurerm_subnet_network_security_group_association" "azure-nsg_association" {
  subnet_id                 = var.vm-subnet_id
  network_security_group_id = azurerm_network_security_group.azure-nsg.id
}


resource "azurerm_public_ip" "azure-public_ip-1" {
  name                         = var.vm-public_ip_1_name
  location                     = var.vm-location
  resource_group_name          = var.vm-resource_group_name
  allocation_method            = var.vm-public_ip_1_type
  sku                          = var.vm-public_ip_1_sku

tags = {
    "ResourceType" = "Public IP"
    "Evironment"   = var.vm-tag_environment
  }
}


resource "azurerm_network_interface" "azure-net_int-1" {
  name                = var.vm-net_int-1
  location            = var.vm-location
  resource_group_name = var.vm-resource_group_name
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ip_configuration {
    name                          = "Internal_IP-1"
    subnet_id                     = var.vm-subnet_id
    private_ip_address_allocation = "Dynamic"
    # private_ip_address_allocation = "Static"
    # private_ip_address            = "10.10.1.122"
        
    public_ip_address_id          = azurerm_public_ip.azure-public_ip-1.id
  }

  tags = {
    "ResourceType" = "Network Interface"
    "Environment"  = var.vm-tag_environment
  }
}


resource "azurerm_marketplace_agreement" "azure_marketplace-ubuntu" {
  publisher = var.vm-virtual_machine_1_source_image_publisher
  offer     = var.vm-virtual_machine_1_source_image_offer
  plan      = var.vm-virtual_machine_1_source_image_sku
}


resource "azurerm_linux_virtual_machine" "azure-linux_virtual_machine-1" {
  name                = var.vm-virtual_machine_1_name
  resource_group_name = var.vm-resource_group_name
  location            = var.vm-location
  size                = var.vm-virtual_machine_1_size
  depends_on          = [azurerm_marketplace_agreement.azure_marketplace-ubuntu, azurerm_network_interface.azure-net_int-1]
    
  network_interface_ids           = [azurerm_network_interface.azure-net_int-1.id]
  computer_name                   = var.vm-virtual_machine_1_computer_name
  admin_username                  = var.vm-virtual_machine_1_admin_user_name
  admin_password                  = var.vm-virtual_machine_1_admin_user_password
  disable_password_authentication = false

  os_disk {
    name                 = "OSDisk"
    caching              = "ReadWrite"
    storage_account_type = var.vm-virtual_machine_1_storage_account_type
  }

  source_image_reference {
    publisher = var.vm-virtual_machine_1_source_image_publisher
    offer     = var.vm-virtual_machine_1_source_image_offer
    sku       = var.vm-virtual_machine_1_source_image_sku
    version   = var.vm-virtual_machine_1_source_image_version
  }


# Note: non-Microsoft images require the plan block,
#       whereas Microsoft Published images do not require a plan block.
#       If the 'plan' block is present it causes the following error:
#
#          Message="User failed validation to purchase resources.
#                   Error message: 'Offer with PublisherId: 'canonical', OfferId: '0001-com-ubuntu-server-lunar' cannot be purchased due to validation errors.
#                   For more information see details. Correlation Id: '...' The Offer: '0001-com-ubuntu-server-lunar' cannot be purchased by subscription: '...'
#                   as it is not to be sold in market: 'GB'. Please choose a subscription which is associated with a different market. 

  #plan {
  #  name      = var.vm-virtual_machine_1_plan_name
  #  product   = var.vm-virtual_machine_1_plan_product
  #  publisher = var.vm-virtual_machine_1_plan_publisher
  #}

  admin_ssh_key {
    username   = var.vm-virtual_machine_1_admin_user_name
    public_key = file(var.vm-virtual_machine_1_public_key)
  }

  boot_diagnostics {
    storage_account_uri = var.vm-virtual_machine_1_boot_diagnostic_uri
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    "ResourceType" = "Virtual Machine"
    "Environment"  = var.vm-tag_environment
  }
}
