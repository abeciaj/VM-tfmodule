resource "azurerm_virtual_network" "vm_network" {
  name                = "${local.name}-net-${var.instance_number}"
  address_space       = var.address_space
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = "${local.name}-sub-${var.instance_number}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vm_network.name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${local.name}-nic-${var.instance_number}"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "${local.name}-vm-${var.instance_number}"
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_password                  = var.admin_password
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}