variable "address_space" {
    description = "Vnet CIDR range"
      
}

variable "location" {
    description = "Location of the resources created"
    type = string
}

variable "resource_group_name" {
    description = "name of the resource group"
    type = string
}

variable "name" {
    description = "Name of the Vnet"
    type = string
}

variable "address_prefixes_pub_1" {
    description = "Public subnet 1 CIDR range"
    
}

variable "address_prefixes_pub_2" {
    description = "Public subnet 2 CIDR range"
    
}

variable "address_prefixes_pvt_1" {
    description = "Private subnet 1 CIDR range"  
}

variable "address_prefixes_pvt_2" {
    description = "Private subnet 2 CIDR range"
}

variable "virtual_network_name" {
    description = "Name of the virtual network"
    type = string
    default = "azurerm_virtual_network.oswin_Vnet.name"
}
