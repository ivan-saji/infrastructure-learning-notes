resource "azurerm_resource_group" "rg" {
  name     = "rg-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "snet" {
  name                 = "snet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "vmnic" {
  name                = "vmnic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#Creating Provisioners

resource "null_resource" "deployment_prep" {
    triggers = {
        always_run = "${timestamp()}"
    }

  provisioner "local-exec" {
    command = "echo 'Provisioning VM' at ${timestamp()}" > provisioner.log
  }

}


resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "vm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1s"
  admin_username                  = "testadmin"
  admin_password                  = "Password1234!"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vmnic.id,
  ]
  depends_on = [null_resource.deployment_prep]
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "20_04-lts"
    version   = "latest"
  }
}