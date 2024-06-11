
resource "azurerm_linux_virtual_machine" "Pvt_VM" {
  name                = "Private_VM"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  network_interface_ids = var.network_interface_ids

  admin_ssh_key {
    username   = var.username
    public_key = var.key_filepath
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}
