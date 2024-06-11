

resource "azurerm_public_ip" "lb" {
  name                = "PublicIPForLB"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "example" {
  name                = "TestLoadBalancer"
  location            = var.location
  resource_group_name = var.resource_group_name


  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb.id
}
}

# applicaion gateway
locals {
  backend_address_pool_name      = "${Vnet_name}-beap"
  frontend_port_name             = "${Vnet_name}-feport"
  frontend_ip_configuration_name = "${Vnet_name}-feip"
  http_setting_name              = "${Vnet_name}-be-htst"
  listener_name                  = "${Vnet_name}-httplstn"
  request_routing_rule_name      = "${Vnet_name}-rqrt"
  redirect_configuration_name    = "${Vnet_name}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = "osfin-appgateway"
  resource_group_name =  "local.resorce"
  location            = local.location
  enable_http2        =  true

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = Pri_sub_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.example.id
  }

  frontend_ip_configuration {
    name                          = "appGwPrivateFrontendIpIPv4"
    private_ip_address_allocation = "Static"
    subnet_id                     = Pri_sub_id

    }
  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  ssl_certificate {
    name = "osfin-cert"
  }
  depends_on = [
    azurerm_public_ip.pub_ip,
    azurerm_subnet.private_subnet_1,
  ]
}
