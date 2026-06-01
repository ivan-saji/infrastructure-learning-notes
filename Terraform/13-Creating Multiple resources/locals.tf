locals {
    #Infra location
    location = "West Europe"

    #Infra Resource Group name
    resource_group_name = "rg02-infra"

    #Vnet Details
    vnet_name = "rg02-vnet01-infra"
    vnet_address_space = ["10.0.0.0/16"]
}