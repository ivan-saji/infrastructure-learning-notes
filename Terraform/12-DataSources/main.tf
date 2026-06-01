variable "prefix" {
  default = "day13"
}

resource "azurerm_resource_group" "rg-shared-resources" {
  name     = "rg-shared-resources"
  #this will take the location of resource group created in azure and use it for the resource group created by terraform
  location = data.azurerm_resource_group.rg-shared-resources.location
}

#using datasources to reference the existing Virtual Network and Subnet present in azure

data "azurerm_virtual_network" "tf-vnet-shared" {
  name                = "tf-vnet-shared"
  resource_group_name = rg-shared-resources.rg-shared-resources.name
}

data "azurerm_subnet" "tf-vm-subnet" {
  name                 = "tf-subnet-shared"
  virtual_network_name = data.azurerm_virtual_network.tf-vnet-shared.name
  resource_group_name = data.azurerm_virtual_network.tf-vnet-shared.resource_group_name
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = rg-shared-resources.rg-shared-resources.location
  resource_group_name = rg-shared-resources.rg-shared-resources.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = data.azurerm_subnet.tf-vm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = rg-shared-resources.rg-shared-resources.location
  resource_group_name   = rg-shared-resources.rg-shared-resources.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

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