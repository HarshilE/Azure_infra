variable "name" {
    description = "name of the DB"
}

variable "location" {
    description = "Loc of Db"
}

variable "resource_group_name" {
    description = "resource group name" 
}

variable "administrator_login" {
    type = string
}

variable "administrator_login_password" {
    type = string  
}

variable "sku_name" {
  type = string
}

variable "storage_mb" {
    description = "storage size"
}

/*variable "version" {
    type = number 
}*/
