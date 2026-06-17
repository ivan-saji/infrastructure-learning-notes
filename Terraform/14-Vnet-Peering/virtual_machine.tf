resource "azurerm_network_interface" "vm01-nic" {
  name                = "vm01-nic"
  location            = azurerm_resource_group.rg02.location
  resource_group_name = azurerm_resource_group.rg02.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.vnet01-default-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm01" {
  name                  = "vm01"
  location              = azurerm_resource_group.rg02.location
  resource_group_name   = azurerm_resource_group.rg02.name
  network_interface_ids = [azurerm_network_interface.vm01-nic.id]
  vm_size               = "Standard_D2_v4"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 30
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}



#VM in VNET 2

#VM in VNET 2
resource "azurerm_network_interface" "vm02-nic" {
  name                = "vm02-nic"
  location            = azurerm_resource_group.rg02.location
  resource_group_name = azurerm_resource_group.rg02.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.vnet02-default-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm02" {
  name                  = "vm02"
  location              = azurerm_resource_group.rg02.location
  resource_group_name   = azurerm_resource_group.rg02.name
  network_interface_ids = [azurerm_network_interface.vm02-nic.id]
  vm_size               = "Standard_D2_v4"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 30
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}



