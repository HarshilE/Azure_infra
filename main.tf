
#creation of virtual resource group
resource "azurerm_resource_group" "osfin_RG" {
  name     = "oswin-test"
  location = "South India"
}

#creation of VNet
module "VNet" {
  source = "./modules/VNet/"
  location            = azurerm_resource_group.osfin_RG.location
  resource_group_name = azurerm_resource_group.osfin_RG.name
  address_space       = "10.0.0.0/16"
  name                = "Test-network"
  address_prefixes_pvt_1 = "10.0.3.0/24"
  address_prefixes_pvt_2 = "10.0.4.0/24"
  address_prefixes_pub_1 = "10.0.1.0/24"
  address_prefixes_pub_2 = "10.0.2.0/24"
}

#creation of Public VM
module "Pub_VM" {
  source = "./modules/VM/Pub_VM/"
  location            = azurerm_resource_group.osfin_RG.location
  resource_group_name = azurerm_resource_group.osfin_RG.name
  size = "Standard_F2"
  network_interface_ids = [module.VNet.Pub_network_interface_ids]
  admin_username = "admin_username"
  username = "admin_user"
  key_filepath = file("/home/harshil/harshil.pub")
  publisher = "Canonical"
  offer = "0001-com-ubuntu-server-jammy"
  sku = "22_04-lts"
  #version = "latest"
}

#creation of Private VM

module "Pvt_VM" {
  source = "./modules/VM/Pvt_VM/"
  location            = azurerm_resource_group.osfin_RG.location
  resource_group_name = azurerm_resource_group.osfin_RG.name
  size = "Standard_F2"
  network_interface_ids = [module.VNet.Pvt_network_interface_ids]
  admin_username = "admin_username"
  username = "admin_user"
  key_filepath = file("/home/harshil/harshil.pub")
  publisher = "Canonical"
  offer = "0001-com-ubuntu-server-jammy"
  sku = "22_04-lts"
  #version = "latest"
}

#creation of Mysql database

module "DB_Mysql" {
  source = "./modules/DB_MySql/"
  name = "mysqlserver"
  resource_group_name = azurerm_resource_group.osfin_RG.name
  location = azurerm_resource_group.osfin_RG.location
  administrator_login = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"
  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  #version    = "5.7" 
}

module "LB" {
  source = "./modules/LB/"
  location = azurerm_resource_group.osfin_RG.location
  resource_group_name = azurerm_resource_group.osfin_RG.name
}



