/*resource "azurerm_resource_group" "oswin_RG" {
  name     = "oswin-test"
  location = "South India"
}


resource "azurerm_network_security_group" "oswin-SG" {
  name                = "Test-security-group"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name
}

resource "azurerm_virtual_network" "oswin-Vnet" {
  name                = "Test-network"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name
  address_space       = ["10.0.0.0/16"]
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "public_subnet_1" {
    name = "public-subnet-1"
    resource_group_name = azurerm_resource_group.oswin_RG.name
    virtual_network_name = azurerm_virtual_network.oswin-Vnet.name
    address_prefixes = ["10.0.1.0/24"]  
  
}


resource "azurerm_subnet" "public_subnet_2" {
    name = "public-subnet-2"
    resource_group_name = azurerm_resource_group.oswin_RG.name
    virtual_network_name = azurerm_virtual_network.oswin-Vnet.name
    address_prefixes = ["10.0.2.0/24"]  
  
}


resource "azurerm_subnet" "private_subnet_1" {
    name = "private-subnet-1"
    resource_group_name = azurerm_resource_group.oswin_RG.name
    virtual_network_name = azurerm_virtual_network.oswin-Vnet.name
    address_prefixes = ["10.0.3.0/24"]  
  
}

resource "azurerm_subnet" "private_subnet_2" {
    name = "public-subnet-2"
    resource_group_name = azurerm_resource_group.oswin_RG.name
    virtual_network_name = azurerm_virtual_network.oswin-Vnet.name
    address_prefixes = ["10.0.4.0/24"]  
  
}

resource "azurerm_public_ip" "pub_ip" {
    name                = "test-public-ip"
   location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name
  allocation_method   = "Dynamic"
}
resource "azurerm_network_interface" "public_nic" {
  name                = "public-nic"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_network_interface" "private_nic" {
  name                = "private-nic"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_nat_gateway" "test_nat" {
  name                = "test-nat-gateway"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "test" {
  nat_gateway_id = azurerm_nat_gateway.test.id
  public_ip_address_id = azurerm_public_ip.example.id
}

resource "azurerm_subnet_nat_gateway_association" "example1" {
  subnet_id = azurerm_subnet.private_subnet_1.id
  nat_gateway_id = azurerm_nat_gateway.test_nat.id
}

resource "azurerm_subnet_nat_gateway_association" "example2" {
  subnet_id = azurerm_subnet.private_subnet_2.id
  nat_gateway_id = azurerm_nat_gateway.test_nat.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = "test-nsg"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name

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
}*/



resource "azurerm_resource_group" "oswin_RG" {
  name     = "oswin-test"
  location = "South India"
}

resource "azurerm_network_security_group" "oswin_SG" {
  name                = "Test-security-group"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name
}

resource "azurerm_virtual_network" "oswin_Vnet" {
  name                = "Test-network"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "public_subnet_1" {
  name                 = "public-subnet-1"
  resource_group_name  = azurerm_resource_group.oswin_RG.name
  virtual_network_name = azurerm_virtual_network.oswin_Vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "public_subnet_2" {
  name                 = "public-subnet-2"
  resource_group_name  = azurerm_resource_group.oswin_RG.name
  virtual_network_name = azurerm_virtual_network.oswin_Vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "private_subnet_1" {
  name                 = "private-subnet-1"
  resource_group_name  = azurerm_resource_group.oswin_RG.name
  virtual_network_name = azurerm_virtual_network.oswin_Vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "private_subnet_2" {
  name                 = "private-subnet-2"
  resource_group_name  = azurerm_resource_group.oswin_RG.name
  virtual_network_name = azurerm_virtual_network.oswin_Vnet.name
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "test-public-ip"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "public_nic" {
  name                = "public-nic"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_network_interface" "private_nic" {
  name                = "private-nic"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_nat_gateway" "test_nat" {
  name                = "test-nat-gateway"
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name
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
  location            = azurerm_resource_group.oswin_RG.location
  resource_group_name = azurerm_resource_group.oswin_RG.name

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
