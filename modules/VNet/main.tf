resource "azurerm_virtual_network" "osfin_Vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.address_space]
}

resource "azurerm_subnet" "public_subnet_1" {
  name                 = "public-subnet-1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.address_prefixes_pub_1]
}

resource "azurerm_subnet" "public_subnet_2" {
  name                 = "public-subnet-2"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.address_prefixes_pub_2]
}

resource "azurerm_subnet" "private_subnet_1" {
  name                 = "private-subnet-1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.address_prefixes_pvt_1]
}

resource "azurerm_subnet" "private_subnet_2" {
  name                 = "private-subnet-2"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.address_prefixes_pvt_2]
}


resource "azurerm_network_security_group" "osfin_SG" {
  name                = "Test-security-group"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_public_ip" "test" {
  name                = "test-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "public_nic" {
  name                = "public-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.test.id
  }
}

resource "azurerm_network_interface" "private_nic" {
  name                = "private-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_nat_gateway" "test_nat" {
  name                = "test-nat-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_subnet_nat_gateway_association" "example1" {
  subnet_id      = azurerm_subnet.private_subnet_1.id
  nat_gateway_id = azurerm_nat_gateway.test_nat.id
}

resource "azurerm_subnet_nat_gateway_association" "example2" {
  subnet_id      = azurerm_subnet.private_subnet_2.id
  nat_gateway_id = azurerm_nat_gateway.test_nat.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = "test-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "public" {
  network_interface_id      = azurerm_network_interface.public_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
