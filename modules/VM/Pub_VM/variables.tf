
variable "resource_group_name" {
    description = "name of the resource group"
    type = string
}

variable "location" {
    description = "Location of the resources created"
    type = string
}

variable "size" {
    description = "size of the instance"
    type = string
}

variable "network_interface_ids" {
    description = "VNet output value"
}

variable "admin_username" {
    description = "name of the admin user"
}

variable "username" {
    description = "username specified" 
}

variable "key_filepath" {
  description = "key-pair file path"
}

variable "publisher" {
    description = "publisher detials"  
}

variable "offer" {
    description = "offer details"  
}

variable "sku" {
    description = "sku details"
}
