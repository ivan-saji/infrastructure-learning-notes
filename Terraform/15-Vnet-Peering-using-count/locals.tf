locals {
    vnets = {
        vnet1 = {
            name = "vnet1"
            address_space = "10.0.0.0/16"
            subnet = "10.0.1.0/24"
        }

        vnet2 = {
            name = "vnet2"
            address_space = "10.1.0.0/16"
            subnet = "10.1.1.0/24"
        }
    }
}