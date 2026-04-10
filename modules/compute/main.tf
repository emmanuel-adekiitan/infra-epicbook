# Frontend Public IP
resource "azurerm_public_ip" "pip" {
  name                = "frontend-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

# Network Interfaces
resource "azurerm_network_interface" "frontend" {
  name                = "frontend-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.frontend_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# NSG Association
resource "azurerm_network_interface_security_group_association" "fe_assoc" {
  network_interface_id      = azurerm_network_interface.frontend.id
  network_security_group_id = var.frontend_nsg_id
}

# VM
resource "azurerm_linux_virtual_machine" "frontend" {
  name                = "vm-frontend"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.frontend.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

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