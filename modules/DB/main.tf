resource "azurerm_mysql_server" "my_sql_server" {
  name                = var.name
  location            = var.location
  resource_group_name = var. resource_group_name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "my_DB" {
  name                = var.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.my_sql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_mysql_flexible_server" "mysql_db" {
  location                     = locals.location
  name                         = "mysqlfs-${locals.name}"
  resource_group_name          = locals.resource_group_name
  administrator_login          = var.mysql_admin_login
  administrator_password       = var.mysql_admin_passwd
  backup_retention_days        = 7
  delegated_subnet_id          = local.private_subnet_id
  geo_redundant_backup_enabled = false
  private_dns_zone_id          = azurerm_private_dns_zone.default.id
  sku_name                     = "GP_Standard_D2ds_v4"
  version                      = "8.0.35"

  high_availability {
    mode                      = "SameZone"
  }
  maintenance_window {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }
  storage {
    iops    = 360
    size_gb = 100
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}
