resource "azurerm_network_interface" "vm" {
  name                = "${var.vm_name}-nic"
  location            = module.rg.location
  resource_group_name = module.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnets["app"].resource_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = module.rg.name
  location            = module.rg.location
  size                = "Standard_B1s"
  admin_username      = var.vm_admin_username

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = var.vm_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  tags = var.tags
}
