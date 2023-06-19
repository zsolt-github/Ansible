resource "random_id" "random_vm" {
  byte_length = 2
}

resource "azurerm_network_security_group" "nsg" {
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


resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.vm-subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


resource "azurerm_public_ip" "public_ip-1" {
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


resource "azurerm_network_interface" "net_int-1" {
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
        
    public_ip_address_id          = azurerm_public_ip.public_ip-1.id
  }

  tags = {
    "ResourceType" = "Network Interface"
    "Environment"  = var.vm-tag_environment
  }
}


resource "azurerm_marketplace_agreement" "azure_marketplace-ubuntu" {
  for_each  = var.vm-webserver
  publisher = each.value["publisher"]
  offer     = each.value["offer"]
  plan      = each.value["sku"]
}


resource "azurerm_linux_virtual_machine" "webserver" {
  name                            = var.vm-webserver_name
  for_each                        = var.vm-webserver
  #name                            = "${each.value["name"]}-${lower(random_id.random-vm.hex)}"
  resource_group_name             = var.vm-resource_group_name
  location                        = var.vm-location
  size                            = each.value["size"]
  depends_on                      = [azurerm_marketplace_agreement.azure_marketplace-ubuntu, azurerm_network_interface.net_int-1]
    
  network_interface_ids           = [azurerm_network_interface.net_int-1.id]
  computer_name                   = each.value["computer_name"]
  admin_username                  = each.value["admin_username"]
  admin_password                  = each.value["admin_password"]
  disable_password_authentication = each.value["disable_password_authentication"]

  os_disk {
    name                          = each.value["os_disk_name"]
    caching                       = each.value["os_disk_caching"]
    storage_account_type          = each.value["storage_account_type"]
  }

  source_image_reference {
    publisher                     = each.value["publisher"]
    offer                         = each.value["offer"]
    sku                           = each.value["sku"]
    version                       = each.value["version"]
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
  #  name                       = each.value["sku"]
  #  product                    = each.value["offer"]
  #  publisher                  = each.value["publisher"]
  #}

  admin_ssh_key {
    username                    = each.value["admin_username"]
    public_key                  = file(each.value["public_key"])
  }

  boot_diagnostics {
    storage_account_uri         = var.vm-webserver-boot_diag_uri
  }

  identity {
    type                        = each.value["identity_type"]
  }

  tags = {
    "ResourceType"              = "Virtual Machine"
    "Environment"               = var.vm-tag_environment
  }
}
